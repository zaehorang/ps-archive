//
//  1717.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 12/15/25.
//  https://www.acmicpc.net/problem/1717

import Foundation

func _1717() {
    struct UnionFind {
        private var arr: [Int]
        
        init(_ n: Int) {
            arr = .init(repeating: -1, count: n + 1)
        }
        
        mutating func union(_ a: Int, _ b: Int) {
            var rootA = find(a)
            var rootB = find(b)
            
            if rootA == rootB { return }
            
            // b가 랭크가 더 크면
            if arr[rootA] > arr[rootB] { swap(&rootA, &rootB) }
            if arr[rootA] == arr[rootB] { arr[rootA] -= 1 }
            
            arr[rootB] = rootA
        }
        
        mutating func find(_ a: Int) -> Int {
            if arr[a] < 0 { return a }
            arr[a] = find(arr[a])
            
            return arr[a]
        }
    }
    
    let nm = readLine()!.split(separator: " ").map { Int($0)! }
    let (n, m) = (nm[0], nm[1])
    
    var uf = UnionFind(n)
    
    for _ in 0..<m {
        let abc = readLine()!.split(separator: " ").map { Int($0)! }
        let (a, b, c) = (abc[0], abc[1], abc[2])
        
        if a == 1 {
            let rootB = uf.find(b)
            let rootC = uf.find(c)
            
            rootB == rootC ? print("YES") : print("NO")
        } else {
            uf.union(b, c)
        }
    }
}
