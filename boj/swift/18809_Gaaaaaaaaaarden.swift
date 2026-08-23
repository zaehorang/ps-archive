//
// 18809.swift
// Swift_Algorithm
//
// Created by zaehorang on 2026/3/21.
// https://acmicpc.net/problem/18809
//

import Foundation

func _18809() {
    // Your solution here
    let NMGR = readLine()!.split(separator: " ").compactMap { Int($0) }
    let (n, m, g, r) = (NMGR[0], NMGR[1], NMGR[2], NMGR[3])
    
    var table: [[Int]] = []
    for _ in 0..<n {
        table.append(
            readLine()!.split(separator: " ").compactMap { Int($0) }
        )
    }
    
    var points: [(Int, Int)] = []
    
    for i in 0..<n {
        for j in 0..<m where table[i][j] == 2 {
            points.append((i, j))
        }
    }
    
    // red = 1, green = 2
    var isUsed: [Int] = .init(repeating: 0, count: points.count)
    var answer = 0
    let directions = [(1, 0), (-1, 0), (0, 1), (0, -1)]
    
    func bfs() {
        var time: [[Int]] = .init(repeating: Array(repeating: -1, count: m), count: n)
        var color: [[Int]] = .init(repeating: Array(repeating: 0, count: m), count: n)
        var queue: [(x: Int, y: Int, color: Int, time: Int)] = []
        var head = 0
        
        for i in 0..<points.count {
            let selectedColor = isUsed[i]
            if selectedColor == 0 { continue }
            
            let (x, y) = points[i]
            time[x][y] = 0
            color[x][y] = selectedColor
            queue.append((x, y, selectedColor, 0))
        }
        
        var flowers = 0
        
        while head < queue.count {
            let current = queue[head]
            head += 1
            
            // 이미 꽃이 된 칸은 더 이상 퍼지면 안 됨
            if color[current.x][current.y] == 3 { continue }
            
            for (dx, dy) in directions {
                let nx = current.x + dx
                let ny = current.y + dy
                
                if nx < 0 || ny < 0 || nx >= n || ny >= m { continue }
                if table[nx][ny] == 0 { continue }
                
                if time[nx][ny] == -1 {
                    time[nx][ny] = current.time + 1
                    color[nx][ny] = current.color
                    queue.append((nx, ny, current.color, current.time + 1))
                } else if time[nx][ny] == current.time + 1,
                          color[nx][ny] != current.color,
                          color[nx][ny] != 3 {
                    color[nx][ny] = 3
                    flowers += 1
                }
            }
        }
        
        answer = max(answer, flowers)
    }
    
    func recursion(_ current: Int, _ red: Int, _ green: Int) {
        if red == r && green == g {
            // 여기서 bfs로 최신화?
            bfs()
            return
        }
        guard current < points.count else { return }
        if points.count - current < (r - red) + (g - green) { return }
        if red > r || green > g { return }
        
        recursion(current + 1, red, green)
        
        if red < r {
            isUsed[current] = 1
            recursion(current + 1, red + 1, green)
            isUsed[current] = 0
        }
        
        if green < g {
            isUsed[current] = 2
            recursion(current + 1, red, green + 1)
            isUsed[current] = 0
        }
    }
    recursion(0, 0, 0)
    print(answer)
}
