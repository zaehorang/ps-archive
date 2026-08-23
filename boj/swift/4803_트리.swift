//
//  4803.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 10/31/25.
//

import Foundation

func _4803() {
    var mn = readLine()!.split(separator: " ").map { Int($0)! }
    var caseNumber = 0
    
    func treeCountString(_ n: Int) -> String {
        if n == 0 {
            return "No trees."
        } else if n == 1 {
            return "There is one tree."
        } else {
            return "A forest of \(n) trees."
        }
    }
    
    while !(mn[0] == 0 && mn[1] == 0) {
        caseNumber += 1
        
        var treeCount = 0
        var tree = [[Int]].init(repeating: [], count: mn[0] + 1)
        // make tree
        for _ in 0..<mn[1] {
            let edge = readLine()!.split(separator: " ").map { Int($0)! }
            
            tree[edge[0]].append(edge[1])
            tree[edge[1]].append(edge[0])
        }
        
        var isVisted: [Bool] = .init(repeating: false, count: mn[0] + 1)
        
        var nodeCount = 0
        var edgeCount = 0
        
        func dfs(_ current: Int) {
            nodeCount += 1
            isVisted[current] = true
            
            for next in tree[current] {
                edgeCount += 1
                
                if !isVisted[next] {
                    dfs(next)
                }
            }
        }

        for i in 1...mn[0] where !isVisted[i] {
            dfs(i)
            
            if nodeCount == (edgeCount / 2) + 1 { treeCount += 1 }
            
            nodeCount = 0
            edgeCount = 0
        }
    
        mn = readLine()!.split(separator: " ").map { Int($0)! }
        
        print("Case \(caseNumber): \(treeCountString(treeCount))")
    }
}
