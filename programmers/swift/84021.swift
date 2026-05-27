//
// 84021.swift
// Swift_Algorithm
//
// Created by zaehorang on 2026/4/18.
// https://school.programmers.co.kr/learn/courses/30/lessons/84021
//

import Foundation

func _84021() {
    // Your solution here
    struct Point: Comparable {
        let row: Int
        let col: Int
        
        static func < (lhs: Point, rhs: Point) -> Bool {
            if lhs.row == rhs.row { return lhs.col < rhs.col }
            return lhs.row < rhs.row
        }
    }

    func solution(_ game_board: [[Int]], _ table: [[Int]]) -> Int {
        let n = game_board.count
        let directions = [(1, 0), (-1, 0), (0, 1), (0, -1)]
        
        func normalize(_ coords: [Point]) -> [Point] {
            let minRow = coords.map { $0.row }.min() ?? 0
            let minCol = coords.map { $0.col }.min() ?? 0
            
            return coords
                .map { Point(row: $0.row - minRow, col: $0.col - minCol) }
                .sorted()
        }
        
        // 정규화된 도형을 90도 시계 방향으로 회전
        // (row, col) -> (col, maxRow - row)
        // 회전 시 생기는 음수 좌표를 없애기 위해 maxRow만큼 평행이동한 뒤 다시 정규화
        func rotate(_ shape: [Point]) -> [Point] {
            let maxRow = shape.map { $0.row }.max() ?? 0
            let rotated = shape.map { Point(row: $0.col, col: maxRow - $0.row) }
            return normalize(rotated)
        }
        
        func extractShapes(from board: [[Int]], target: Int) -> [[Point]] {
            var visited = Array(repeating: Array(repeating: false, count: n), count: n)
            var shapes: [[Point]] = []
            
            func bfs(_ startRow: Int, _ startCol: Int) -> [Point] {
                var queue: [Point] = [Point(row: startRow, col: startCol)]
                var index = 0
                visited[startRow][startCol] = true
                
                var coords: [Point] = [Point(row: startRow, col: startCol)]
                
                while index < queue.count {
                    let current = queue[index]
                    index += 1
                    
                    for (dr, dc) in directions {
                        let nr = current.row + dr
                        let nc = current.col + dc
                        
                        if nr < 0 || nr >= n || nc < 0 || nc >= n { continue }
                        if visited[nr][nc] || board[nr][nc] != target { continue }
                        
                        visited[nr][nc] = true
                        let next = Point(row: nr, col: nc)
                        queue.append(next)
                        coords.append(next)
                    }
                }
                
                return normalize(coords)
            }
            
            for row in 0..<n {
                for col in 0..<n {
                    if !visited[row][col] && board[row][col] == target {
                        shapes.append(bfs(row, col))
                    }
                }
            }
            
            return shapes
        }
        
        let emptySpaces = extractShapes(from: game_board, target: 0)
        let puzzlePieces = extractShapes(from: table, target: 1)
        var used = Array(repeating: false, count: puzzlePieces.count)
        var answer = 0
        
        for emptySpace in emptySpaces {
            var matched = false
            
            for i in 0..<puzzlePieces.count {
                if used[i] || puzzlePieces[i].count != emptySpace.count { continue }
                
                var rotatedPiece = puzzlePieces[i]
                
                for _ in 0..<4 {
                    if rotatedPiece == emptySpace {
                        used[i] = true
                        answer += emptySpace.count
                        matched = true
                        break
                    }
                    rotatedPiece = rotate(rotatedPiece)
                }
                
                if matched { break }
            }
        }
        
        return answer
    }
    
}
