//
// 2667.swift
// Swift_Algorithm
//
// Created by zaehorang on 2026/2/15.
// https://acmicpc.net/problem/2667
//

import Foundation

func _2667() {
    // Your solution here
    let n = Int(readLine()!)!
    var table: [[Int]] = []
    
    for _ in 0..<n {
        table.append(readLine()!.compactMap { Int(String($0)) })
    }
    
    let dx = [0, 1, 0, -1]
    let dy = [1, 0, -1, 0]
    
    var isVisted: [[Bool]] = .init(repeating: .init(repeating: false, count: n), count: n)
    
    var queue: [(Int, Int)] = []
    
    var ans: [Int] = []
    
    for x in 0..<n {
        for y in 0..<n {
            guard !isVisted[x][y] else { continue }
            isVisted[x][y] = true
            
            if table[x][y] == 1 {
                queue.append((x, y))
                var count = 1
                
                while !queue.isEmpty {
                    let top = queue.removeFirst()
                    
                    for i in 0..<4 {
                        let nx = top.0 + dx[i]
                        let ny = top.1 + dy[i]
                        
                        guard nx >= 0 && nx < n else { continue }
                        guard ny >= 0 && ny < n else { continue }
                        guard !isVisted[nx][ny] else { continue }
                        
                        isVisted[nx][ny] = true
                        
                        if table[nx][ny] == 1 {
                            count += 1
                            queue.append((nx, ny))
                        }
                    }
                }
                ans.append(count)
            }
        }
    }
    print(ans.count)
    print(ans.sorted().map { String($0) }.joined(separator: "\n"))
}


func _2667_1() {
    // Your solution here
    let n = Int(readLine()!)!
    var table: [[UInt8]] = []

    for _ in 0..<n {
        table.append(readLine()!.utf8.map { $0 == 49 ? 1 : 0} )
    }

    let dx = [0, 1, 0, -1]
    let dy = [1, 0, -1, 0]

    var isVisited: [[Bool]] = .init(repeating: .init(repeating: false, count: n), count: n)

    var queue: [(Int, Int)] = []
    queue.reserveCapacity(n * n)
    var head = 0

    var ans: [Int] = []

    for x in 0..<n {
        for y in 0..<n {
            guard table[x][y] == 1, !isVisited[x][y] else { continue }
            
            isVisited[x][y] = true
            queue.removeAll(keepingCapacity: true)
            head = 0
            queue.append((x, y))
            
            var count = 1
            
            while head < queue.count {
                let (cx, cy) = queue[head]
                head += 1
                
                for i in 0..<4 {
                    let nx = cx + dx[i]
                    let ny = cy + dy[i]
                    
                    guard nx >= 0 && nx < n else { continue }
                    guard ny >= 0 && ny < n else { continue }
                    guard !isVisited[nx][ny] else { continue }
                    guard table[nx][ny] == 1 else { continue }
                    
                    isVisited[nx][ny] = true
                    count += 1
                    queue.append((nx, ny))
                }
            }
            ans.append(count)
        }
    }
    ans.sort()

    var output = "\(ans.count)\n"
    for v in ans { output += "\(v)\n" }
    print(output)

}
