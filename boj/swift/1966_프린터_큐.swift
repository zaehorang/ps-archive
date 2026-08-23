//
// 1966.swift
// Swift_Algorithm
//
// Created by zaehorang on 2026/3/31.
// https://acmicpc.net/problem/1966
//

import Foundation

func _1966() {
    let testCase = Int(readLine()!)!
    
    for _ in 0..<testCase {
        let nm = readLine()!.split(separator: " ").compactMap { Int($0) }
        let m = nm[1]
        let priorities = readLine()!.split(separator: " ").compactMap { Int($0) }
        
        var queue: [(priority: Int, index: Int)] = priorities.enumerated().map {
            (priority: $0.element, index: $0.offset)
        }
        
        var count = 0
        
        while true {
            let current = queue.removeFirst()
            
            if queue.contains(where: { $0.priority > current.priority }) {
                queue.append(current)
            } else {
                count += 1
                
                if current.index == m {
                    print(count)
                    break
                }
            }
        }
    }
}

