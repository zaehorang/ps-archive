//
//  7511.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 12/17/25.
//  https://www.acmicpc.net/problem/7511

import Foundation

func _7511() {
    struct UionFind {
        var table: [Int]
        
        init(_ n: Int) {
            self.table = .init(repeating: -1, count: n)
        }
        
        @discardableResult
        mutating func union(_ a: Int, _ b: Int) -> Bool {
            var rootA = find(a)
            var rootB = find(b)
            
            if rootA == rootB { return false }
            
            if table[rootA] > table[rootB] {
                swap(&rootA, &rootB)
            } else if table[rootA] == table[rootB] {
                table[rootA] -= 1
            }
            
            table[rootB] = rootA
            
            return true
        }
        
        mutating func find(_ n: Int) -> Int {
            if table[n] < 0 { return n }
            table[n] = find(table[n])
            
            return table[n]
        }
    }
    
    let testN = Int(readLine()!)!
    
    for i in 1...testN {
        let n = Int(readLine()!)!
        var connection = UionFind(n)
        
        let k = Int(readLine()!)!
        
        for _ in 0..<k {
            let ab = readLine()!.split(separator: " ").map { Int($0)! }
            connection.union(ab[0], ab[1])
        }
        
        let m = Int(readLine()!)!
        var ans = ""
        
        for _ in 0..<m {
            let uv = readLine()!.split(separator: " ").map { Int($0)! }
            let rootU = connection.find(uv[0])
            let rootV = connection.find(uv[1])
            
           ans += rootU == rootV ? "1\n" : "0\n"
        }
        
        print("Scenario \(i):")
        print(ans, terminator: "\n")
    }
}
