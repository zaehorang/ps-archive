//
//  13418.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 1/4/26.
//  https://www.acmicpc.net/problem/13418

import Foundation

func _13418() {
    struct UnionFind {
        private var arr: [Int]
        
        init(_ n: Int) {
            self.arr = .init(repeating: -1, count: n + 1)
        }
        
        mutating func find(_ n: Int) -> Int {
            if arr[n] < 0 { return n }
            
            arr[n] = find(arr[n])
            
            return arr[n]
        }
        
        mutating func union(_ a: Int, _ b: Int) -> Bool {
            var rootA = find(a)
            var rootB = find(b)
            
            if rootA == rootB { return false }
            
            if arr[rootA] > arr[rootB] {
                swap(&rootA, &rootB)
            } else if arr[rootA] == arr[rootB] {
                arr[rootA] -= 1
            }
            
            arr[rootB] = rootA
            
            return true
        }
    }
    
    let NM = readLine()!.split(separator: " ").compactMap { Int($0) }
    let (N, M) = (NM[0], NM[1])
    
    var edges: [(Int, Int, Int)] = []
    
    
    for _ in 0...M {
        let abc = readLine()!.split(separator: " ").compactMap { Int($0) }
        edges.append((abc[0], abc[1], abc[2]))
        
    }
    
    let bestSortedEdges = edges.sorted { $0.2 > $1.2 }
 
    func getUpperCount(_ edges: [(Int, Int, Int)]) -> Int {
        var uf = UnionFind(N)
        var upperCount = 0
        var count = 0
        
        for (a, b , c) in edges {
            if uf.union(a, b) {
                count += 1
                upperCount += c == 0 ? 1 : 0
            }
            
            if count == N  { break }
        }
        return upperCount
    }
    
    let best = getUpperCount(bestSortedEdges)
    let worst = getUpperCount(bestSortedEdges.reversed())
    
    print((worst * worst) - (best * best))
}
