//
//  1197.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 12/29/25.
//

import Foundation

/// Kruskal Algorithm
func _1197_Kruskal() {
    struct UnionFind {
        private var arr: [Int]
        
        init(_ count: Int) {
            arr = .init(repeating: -1, count: count + 1)
        }
        
        mutating func union(_ a: Int, _ b: Int) -> Bool {
            var rootA = find(a)
            var rootB = find(b)
            
            if rootA == rootB { return false }
            
            if arr[rootA] > arr[rootB] { swap(&rootA, &rootB) }
            
            if arr[rootA] == arr[rootB] { arr[rootA] -= 1 }
            
            arr[rootB] = rootA
            return true
        }
        
        mutating func find(_ a: Int) -> Int {
            if arr[a] < 0 { return a }
            arr[a] = find(arr[a])
            
            return arr[a]
        }
        
    }
    
    let VE = readLine()!.split(separator: " ").compactMap { Int($0) }
    let (V, E) = (VE[0], VE[1])
    
    var uf = UnionFind(V)
    var edges: [[Int]] = []
    
    for _ in 0..<E {
        let abc = readLine()!.split(separator: " ").compactMap { Int($0) }
        edges.append(abc)
    }
    
    edges.sort { $0[2] < $1[2] }
    
    var cnt = 0
    var ans = 0
    
    for edge in edges {
        let (a, b ,c) = (edge[0], edge[1], edge[2])
        
        if !uf.union(a, b) { continue }
        ans += c
        cnt += 1
        
        if cnt == V - 1 { break }
    }
    print(ans)
}


/// Prim's Algorithm
func _1197_Prim() {
    struct Edge {
        let from: Int
        let to: Int
        
        let cost: Int
    }
    
    struct MinEdgeHeap {
        private var queue: [Edge] = [Edge(from: 0, to: 0, cost: 0)]
        private var size = 0
        
        var top: Edge { size >= 1 ? queue[1] : queue[0] }
        var isEmpty: Bool { size == 0 }
        
        private let areSorted: (Edge, Edge) -> Bool = { $0.cost < $1.cost }
        
        mutating func push(_ edge: Edge) {
            queue.append(edge)
            size += 1
            
            var index = size
            
            while index != 1 {
                let parentIndex = index / 2
                
                if areSorted(queue[parentIndex], queue[index]) { break }
                
                queue.swapAt(parentIndex, index)
                index = parentIndex
            }
        }
        
        mutating func pop() -> Edge {
            guard !isEmpty else { return queue[0] }
            
            let top = queue[1]
            queue[1] = queue[size]
            queue.removeLast()
            size -= 1
            
            var index = 1
            
            while 2 * index <= size {
                let leftChildIndex = index * 2
                let rightChildIndex = index * 2 + 1
                
                var targetIndex = leftChildIndex
                
                if rightChildIndex <= size,
                   areSorted(queue[rightChildIndex], queue[leftChildIndex]) {
                    targetIndex = rightChildIndex
                }
                
                if areSorted(queue[index], queue[targetIndex]) { break }
                
                queue.swapAt(index, targetIndex)
                index = targetIndex
            }
        
            return top
        }
    }
    
    let VE = readLine()!.split(separator: " ").compactMap { Int($0) }
    let (V, E) = (VE[0], VE[1])
    
    var graph: [[Edge]] = Array(repeating: [], count: V + 1)

    var check: [Bool] = .init(repeating: false, count: V + 1)
    var count = 0
    
    for _ in 0..<E {
        let abc = readLine()!.split(separator: " ").compactMap { Int($0) }
        graph[abc[0]].append(Edge(from: abc[0], to: abc[1], cost: abc[2]))
        graph[abc[1]].append(Edge(from: abc[1], to: abc[0], cost: abc[2]))
    }
    
    check[1] = true
    var pq = MinEdgeHeap()
    
    for next in graph[1] {
        pq.push(next)
    }
    
    var totalCount = 0
    
    while count < V - 1 {
        let topEdge = pq.pop()
        
        if check[topEdge.to] { continue }
        
        totalCount += topEdge.cost
        count += 1
        check[topEdge.to] = true
        
        graph[topEdge.to].forEach { pq.push($0) }
    }
    
    print(totalCount)
}
