//
//  1976.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 12/18/25.
//  https://www.acmicpc.net/problem/1976

import Foundation

func _1976_BFS() {
    let N = Int(readLine()!)!
    let _ = Int(readLine()!)!
    
    /// Make Graph
    
    var graph: [[Int]] = .init(repeating: .init(repeating: 0, count: N + 1), count: N + 1)
    
    for i in 1...N {
        let data = [0] + readLine()!.split(separator: " ").map { Int($0)! }
        
        for j in 1...N {
            if data[j] == 1 { graph[i][j] = 1 }
        }
    }
    
    /// Solution - BFS
    
    var destinationSet: Set<Int> = []
    readLine()!.split(separator: " ").forEach { destinationSet.insert(Int($0)!) }
    
    var isVisted: [Bool] = .init(repeating: false, count: N + 1)
    
    let first = destinationSet.first!
    var queue: [Int] = [first]
    isVisted[first] = true
    
    while !queue.isEmpty {
        let top = queue.removeFirst()
        
        for n in  1...N where graph[top][n] == 1 {
            guard !isVisted[n] else { continue }
            
            queue.append(n)
            isVisted[n] = true
        }
    }
    
    for n in destinationSet {
        if !isVisted[n] {
            print("NO")
            return
        }
    }
    print("YES")
}


func _1976_UnionFind() {
    struct UnionFind {
        private var table: [Int]
        
        init(_ n: Int) {
            self.table = .init(repeating: -1, count: n + 1)
        }
        
        @discardableResult
        mutating func union(_ a: Int, _ b: Int) -> Bool {
            var rootA = find(a)
            var rootB = find(b)
            
            if rootA == rootB { return false }
            
            if table[rootA] > table[rootB] { swap(&rootA, &rootB)  }
            if table[rootA] == table[rootB] { table[rootA] -= 1 }
            
            table[rootB] = rootA
            
            return true
        }
        
        mutating func find(_ n: Int) -> Int {
            if table[n] < 0 { return n }
            
            table[n] = find(table[n])
            
            return table[n]
        }
    }
    
    /// Solution - Union-Find
    
    let N = Int(readLine()!)!
    let _ = Int(readLine()!)!
    
    var unionFind = UnionFind(N)
    
    for i in 1...N {
        let data = [0] + readLine()!.split(separator: " ").map { Int($0)! }
        
        for j in 1...N where data[j] == 1{
            unionFind.union(i, j)
        }
    }
    
    var destinationSet: Set<Int> = []
    readLine()!.split(separator: " ").forEach { destinationSet.insert(Int($0)!) }
    
    var root = 0
    
    for i in destinationSet {
        let destinationRoot = unionFind.find(i)
        
        if root == 0 {
            root = destinationRoot
            continue
        }
        
        if root != destinationRoot {
            print("NO")
            return
        }
    }
    
    print("YES")
}
