//
//  2623.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 11/18/25.
//

import Foundation

func _2623() {
    let NM = readLine()!.split(separator: " ").map { Int($0)! }
    let (N ,M) = (NM[0], NM[1])
    
    var table: [[Int]] = .init(repeating: [], count: N + 1)
    var indegrees: [Int] = .init(repeating: 0, count: N + 1)
    
    /// Make table and Count indegrees
    for _ in 0..<M {
        let line = readLine()!.split(separator: " ").map { Int($0)! }
        
        var before = 0
        
        for i in line[1...] {
            guard before != 0 else {
                before = i
                continue
            }
            
            table[before].append(i)
            indegrees[i] += 1
            
            before = i
        }
    }
    
    var ans: [Int] = []
    var queue: [Int] = []
    
    for i in 1...N where indegrees[i] == 0 { queue.append(i) }
    
    while !queue.isEmpty {
        let top = queue.removeFirst()
        ans.append(top)
        
        for i in table[top] {
            indegrees[i] -= 1
            if indegrees[i] == 0 { queue.append(i) }
            }
        }
    
    if ans.count == N {
        ans.forEach { print($0) }
    } else {
        print(0)
    }
}
