//
//  2252.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 11/17/25.
//

import Foundation

func _2252() {
    let NM = readLine()!.split(separator: " ").map { Int($0)! }
    let (N, M) = (NM[0], NM[1])
    
    var graph: [[Int]] = .init(repeating: .init(), count: N + 1)
    var indegrees: [Int] = .init(repeating: 0, count: N + 1)
    
    for _ in 0..<M {
        let ab = readLine()!.split(separator: " ").map { Int($0)! }
        let (a, b) = (ab[0], ab[1])
        
        graph[a].append(b)
        indegrees[b] += 1
    }
    
    
    var ans = [Int]()
    var queue = [Int]()
    
    for i in 1...N {
        if indegrees[i] == 0 { queue.append(i) }
    }
    
    
    while !queue.isEmpty {
        let top = queue.removeFirst()
        ans.append(top)
        
        for i in graph[top] {
            indegrees[i] -= 1
            if indegrees[i] == 0 { queue.append(i) }
        }
    }
    
    print(ans
        .map { String($0) }
        .joined(separator: " "))
}


/// dfs로 위상 정렬 구현, 방문 역순이 정렬 순서
func _2252_other() {
    let NM = readLine()!.split(separator: " ").map { Int($0)! }
    let (N, M) = (NM[0], NM[1])
    
    var graph: [[Int]] = .init(repeating: .init(), count: N + 1)
    
    for _ in 0..<M {
        let ab = readLine()!.split(separator: " ").map { Int($0)! }
        let (a, b) = (ab[0], ab[1])
        
        graph[b].append(a)
    }
    
    var isVisted: [Bool] = .init(repeating: false, count: N + 1)
    var ans: [Int] = []
    
    func dfs(_ v: Int) {
        isVisted[v] = true
        
        for i in graph[v] where !isVisted[i]{
            dfs(i)
        }
        
        ans.append(v)
    }
    
    for i in 1...N {
        guard !isVisted[i] else { continue }
        
        dfs(i)
    }
    
    print(ans.map { "\($0)" }.joined(separator: " "))
}
