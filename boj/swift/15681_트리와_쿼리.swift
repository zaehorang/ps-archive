//
//  15681.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 11/2/25.
//

import Foundation

func _15681() {
    let nrq = readLine()!.split(separator: " ").map { Int($0)! }
    let (n, r, q) = (nrq[0], nrq[1], nrq[2])
    
    var isVisted: [Bool] = .init(repeating: false, count: n + 1)
    
    var graph: [[Int]] = .init(repeating: [], count: n + 1)
    
    
    for _ in 1..<n {
        let ab = readLine()!.split(separator: " ").map { Int($0)! }
        
        graph[ab[0]].append(ab[1])
        graph[ab[1]].append(ab[0])
    }
    
    var subTreeSize: [Int] = .init(repeating: 0, count: n + 1)

    @discardableResult
    func dfs(_ current: Int) -> Int {
        isVisted[current] = true
        
        for i in graph[current] where !isVisted[i] {
            subTreeSize[current] += dfs(i)
        }
        
        subTreeSize[current] += 1
        return subTreeSize[current]
    }
    
    dfs(r)
    
    for _ in 0..<q {
        let x = Int(readLine()!)!
        print(subTreeSize[x])
    }
}

/*
 시간초과
func _15681() {
    let nrq = readLine()!.split(separator: " ").map { Int($0)! }
    let (n, r, q) = (nrq[0], nrq[1], nrq[2])
    
    var parents: [Int] = .init(repeating: 0, count: n + 1)
    
    var graph: [[Int]] = .init(repeating: [], count: n + 1)
    
    for _ in 1..<n {
        let ab = readLine()!.split(separator: " ").map { Int($0)! }
        
        graph[ab[0]].append(ab[1])
        graph[ab[1]].append(ab[0])
    }

    // input parents
    func dfs(_ current: Int, parent: Int) {
        parents[current] = parent
        
        for i in graph[current] where i != parent {
            dfs(i, parent: current)
        }
    }
    
    dfs(r, parent: -1)
    
    var ans = 0
    
    func dfsCount(_ node: Int) {
        ans += 1
        for i in graph[node] where i != parents[node] {
            dfsCount(i)
        }
    }
    
    var ansArray: [Int] = []
    
    for _ in 0..<q {
        let x = Int(readLine()!)!
        dfsCount(x)
        ansArray.append(ans)
        ans = 0
    }
    
    ansArray.forEach { print($0) }
}
 */
