//
//  11725.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 10/28/25.
//

import Foundation

func _11725() {
    let n = Int(readLine()!)!
    
    var tree: [[Int]] = .init(repeating: [], count: n + 1)
    
    // make tree
    for _ in 1..<n {
        let ab = readLine()!.split(separator: " ").map { Int($0)! }
        
        tree[ab[1]].append(ab[0])
        tree[ab[0]].append(ab[1])
    }
    
    var parents: [Int] = .init(repeating: 0, count: n + 1)
    var queue = [1]
    
    func bfs() {
        
        while !queue.isEmpty {
            let q = queue.removeFirst()
            
            for i in tree[q] {
                guard parents[i] == 0 else { continue }
                
                parents[i] = q
                queue.append(i)
            }
        }
        
    }
    
    bfs()
    
    parents[2..<n+1].forEach { print($0) }
}
