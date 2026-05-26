//
// 4963.swift
// Swift_Algorithm
//
// Created by zaehorang on 2026/3/5.
// https://acmicpc.net/problem/4963
//

import Foundation

func _4963() {
    // Your solution here
    let dx = [0, 1, 1, 1, 0, -1, -1, -1]
    let dy = [1, 1, 0, -1, -1, -1, 0, 1]

    var ans = ""
    
    while true {
        let wh = readLine()!.split(separator: " ").compactMap { Int($0) }
        let (w, h) = (wh[0], wh[1])
        
        if w == 0 && h == 0 { break }
        
        var table: [[Int]] = []
        
        var queue: [(Int, Int)] = []
        var head = 0
        
        for _ in 0..<h {
            table.append(
                readLine()!.split(separator: " ").compactMap { Int($0) }
            )
        }
        
        var count = 0

        for i in 0..<h {
            for j in 0..<w {
                if table[i][j] == 1 {
                    queue.append((i, j))
                    table[i][j] = 0
                    count += 1
                    
                    while queue.count > head {
                        let (x, y) = queue[head]
                        head += 1
                        
                        
                        for k in 0..<dx.count {
                            let nx = x + dx[k]
                            let ny = y + dy[k]
                            
                            guard nx >= 0 && nx < h else { continue }
                            guard ny >= 0 && ny < w else { continue }
                            guard table[nx][ny] == 1 else { continue }

                            queue.append((nx, ny))
                            table[nx][ny] = 0
                        }
                    }
                }
            }
        }
        ans += "\(count)\n"
    }
    print(ans)
}
