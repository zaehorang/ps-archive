//
// 11559.swift
// Swift_Algorithm
//
// Created by zaehorang on 2026/3/12.
// https://acmicpc.net/problem/11559
//

import Foundation

func _11559() {
    // Your solution here
    typealias Point = (x: Int, y: Int)
    
    var table: [[String]] = []
    
    for _ in 0..<12 {
        table.append(readLine()!.map { String($0) })
    }
    
    var newTable: [[String]] = .init(repeating: [], count: 6)
    
    for i in (0..<6) {
        for j in (0..<12).reversed() {
            newTable[i].append(table[j][i])
        }
    }

    let dx = [0, -1, 0, 1]
    let dy = [1, 0, -1, 0]
    

    var combo = 0
    
    while true {
        var isVisted: [[Bool]] = .init(repeating: .init(repeating: false, count: 12), count: 6)
        
        var removePoints: [Point] = []
        
        func bfs(_ point: Point) {
            var points: [Point] = [point]
            var queue: [Point] = [point]
            
            
            while !queue.isEmpty {
                let (x, y) = queue.removeFirst()
                let value = newTable[x][y]
                
                for i in 0..<4 {
                    let nx = x + dx[i]
                    let ny = y + dy[i]
                    
                    guard nx >= 0 && nx < 6 else { continue }
                    guard ny >= 0 && ny < 12 else { continue }
                    guard !isVisted[nx][ny] else { continue }
                    guard value == newTable[nx][ny] else { continue }
                    
                    queue.append((nx, ny))
                    points.append((nx, ny))
                    isVisted[nx][ny] = true
                }
            }
            
            if points.count >= 4 { removePoints += points }
        }
        
        for x in 0..<6 {
            for y in 0..<12 {
                guard !isVisted[x][y] else { continue }
                guard newTable[x][y] != "." else { continue }
                
                isVisted[x][y] = true
                bfs((x, y))
            }
        }
        
        if removePoints.isEmpty {
            break
        } else {
            combo += 1
            for point in removePoints {
                let (x, y) = point
                newTable[x][y] = ""
                newTable[x].append(".")
            }
            
            for x in 0..<6 {
                newTable[x] = newTable[x].filter { $0 != "" }
            }
        }
    }
    
    print(combo)
}

/*
 테이블을 돌리지 않고 그냥 본 경우
 + Queue를 좀 더 최적화 (head index 사용)
 */

func _11559_1() {
    typealias Point = (r: Int, c: Int)

    var board = (0..<12).map { _ in Array(readLine()!) }

    let dr = [-1, 1, 0, 0]
    let dc = [0, 0, -1, 1]
    var chainCount = 0

    func bfs(startR: Int, startC: Int, visited: inout [[Bool]]) -> [Point] {
        let color = board[startR][startC]
        var queue: [Point] = [(startR, startC)]
        var head = 0
        var group: [Point] = [(startR, startC)]
        visited[startR][startC] = true

        while head < queue.count {
            let (r, c) = queue[head]
            head += 1

            for i in 0..<4 {
                let nr = r + dr[i]
                let nc = c + dc[i]

                guard nr >= 0 && nr < 12 && nc >= 0 && nc < 6 else { continue }
                guard !visited[nr][nc] else { continue }
                guard board[nr][nc] == color else { continue }

                visited[nr][nc] = true
                queue.append((nr, nc))
                group.append((nr, nc))
            }
        }

        return group
    }

    func applyGravity() {
        for c in 0..<6 {
            var writeRow = 11

            for r in stride(from: 11, through: 0, by: -1) {
                if board[r][c] != "." {
                    board[writeRow][c] = board[r][c]
                    if writeRow != r {
                        board[r][c] = "."
                    }
                    writeRow -= 1
                }
            }

            while writeRow >= 0 {
                board[writeRow][c] = "."
                writeRow -= 1
            }
        }
    }

    while true {
        var visited = Array(repeating: Array(repeating: false, count: 6), count: 12)
        var toRemove: [Point] = []

        for r in 0..<12 {
            for c in 0..<6 {
                if board[r][c] == "." || visited[r][c] { continue }

                let group = bfs(startR: r, startC: c, visited: &visited)
                if group.count >= 4 {
                    toRemove += group
                }
            }
        }

        if toRemove.isEmpty { break }

        for (r, c) in toRemove {
            board[r][c] = "."
        }

        applyGravity()
        chainCount += 1
    }

    print(chainCount)
}
