//
//  16398.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 1/3/26.
//  https://www.acmicpc.net/problem/16398

import Foundation

func _16398() {
    struct UnionFind {
        private var data: [Int]
        private let count: Int
        
        init(_ n: Int) {
            self.count = n
            self.data = .init(repeating: -1, count: count)
        }
        
        mutating func union(_ a: Int, _ b: Int) -> Bool {
            var rootA = find(a)
            var rootB = find(b)
            
            if rootA == rootB { return false }
            
            if data[rootA] > data[rootB] {
                swap(&rootA, &rootB)
            }
            
            if data[rootA] == data[rootB] {
                data[rootA] -= 1
            }
            
            data[rootB] = rootA
            
            return true
        }
        
        mutating func find(_ n: Int) -> Int {
            if data[n] < 0 { return n }
            data[n] = find(data[n])
            
            return data[n]
        }
    }
    
    let N = Int(readLine()!)!
    
    var edges: [(Int, Int, Int)] = []
    
    for i in 0..<N {
        let edge = readLine()!.split(separator: " ").compactMap { Int($0) }
        for j in 0..<N {
            edges.append((i, j, edge[j]))
        }
    }
    
    edges.sort { $0.2 < $1.2 }
    
    var uf = UnionFind(N)
    var bestCost = 0
    var count = 0
    
    for edge in edges where uf.union(edge.0, edge.1) {
        bestCost += edge.2
        count += 1
        
        if count == N - 1 { break }
    }
    print(bestCost)
}
