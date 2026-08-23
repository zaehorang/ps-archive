//
// 2206.swift
// Swift_Algorithm
//
// Created by zaehorang on 2026/4/9.
// https://acmicpc.net/problem/2206
//

import Foundation

func _2206() {
    // Your solution here
    typealias Pos = (x: Int, y: Int, canBreak: Int, count: Int)
    
    let nm = readLine()!.split(separator: " ").compactMap { Int($0) }
    let (n, m) = (nm[0], nm[1])
    
    var map: [[Int]] = []
    for _ in 0..<n {
        map.append(readLine()!.compactMap { Int(String($0)) })
    }
    
    var visited = Array(
        repeating: Array(repeating: Array(repeating: false, count: 2), count: m),
        count: n
    )
    
    var queue: [Pos] = [(0, 0, 1, 1)]
    var head = 0
    visited[0][0][1] = true
    
    let dx = [0, 1, 0, -1]
    let dy = [1, 0, -1, 0]
    
    while head < queue.count {
        let (x, y, canBreak, count) = queue[head]
        head += 1
        
        if x == n - 1 && y == m - 1 {
            print(count)
            return
        }
        
        for k in 0..<4 {
            let nx = x + dx[k]
            let ny = y + dy[k]
            
            guard nx >= 0, nx < n, ny >= 0, ny < m else { continue }
            
            if map[nx][ny] == 0 {
                if !visited[nx][ny][canBreak] {
                    visited[nx][ny][canBreak] = true
                    queue.append((nx, ny, canBreak, count + 1))
                }
            } else if map[nx][ny] == 1, canBreak == 1 {
                if !visited[nx][ny][0] {
                    visited[nx][ny][0] = true
                    queue.append((nx, ny, 0, count + 1))
                }
            }
        }
    }
    
    print(-1)
}
