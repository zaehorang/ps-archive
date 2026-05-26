//
//  1647.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 1/3/26.
//  https://www.acmicpc.net/problem/1647

import Foundation

func _1647() {
    struct UnionFind {
        private var data: [Int]
        private var count: Int
        
        init(_ n: Int) {
            self.count = n
            self.data = .init(repeating: -1, count: n + 1)
        }
        
        mutating func find(_ n: Int) -> Int {
            if data[n] < 0 { return n }
            
            data[n] = find(data[n])
            return data[n]
        }
        
        mutating func union(_ a: Int, _ b: Int) -> Bool {
            var rootA = find(a)
            var rootB = find(b)
            
            if rootA == rootB { return false }
            
            if rootA > rootB { swap(&rootA, &rootB) }
            if data[rootA] == data[rootB] { data[rootA] -= 1 }
            
            data[rootB] = rootA
            
            return true
         }
    }
    
    let NM = readLine()!.split(separator: " ").compactMap { Int($0) }
    let (N, M) = (NM[0], NM[1])
    
    if N == 2 {
        print(0)
        return
    }
    
    var edges: [(Int, Int, Int)] = []
    
    for _ in 0..<M {
        let edge = readLine()!.split(separator: " ").compactMap { Int($0) }
        edges.append((edge[0], edge[1], edge[2]))
    }
    
    edges.sort { $0.2 < $1.2 }
    
    var uf = UnionFind(N)
    var count = 0
    var bestCost = 0
    
    for edge in edges {
        if uf.union(edge.0, edge.1) {
            bestCost += edge.2
            count += 1
        }
        
        if count == N - 2 { break }
    }
    print(bestCost)
}


/// 시간초과
func _1647_other() {
    struct Edge {
        var from = 0
        var to = 0
        var cost = 0
    }
    
    struct MinHeap {
        private var elems: [Edge] = [Edge()]
        private var areSorted: (Edge, Edge) -> Bool =
        { $0.cost < $1.cost }
        
        var size = 0
        var isEmpty: Bool { size == 0 ? true: false }
        
        mutating func push(_ n: Edge) {
            elems.append(n)
            size += 1
            
            var index = size
            
            while index > 1 {
                
                let parentIndex = index / 2
                
                if areSorted(elems[parentIndex], elems[index]) {
                    break
                }
                
                elems.swapAt(index, parentIndex)
                index = parentIndex
            }
        }
        
        mutating func pop() -> Edge {
            guard !isEmpty else { return Edge() }
            
            let top = elems[1]
            elems[1] = elems[size]
            elems.removeLast()
            size -= 1
            
            var index = 1
            
            while 2 * index <= size {
                let leftChildIndex = 2 * index
                let rightChildIndex = 2 * index + 1
                
                var targeIndex = leftChildIndex
                
                if rightChildIndex <= size, areSorted(elems[rightChildIndex], elems[leftChildIndex]) {
                    targeIndex = rightChildIndex
                }
                
                if areSorted(elems[index], elems[targeIndex]) {
                    break
                }
                
                elems.swapAt(index, targeIndex)
                index = targeIndex
            }
            
            return top
        }
        
    }
    
    let NM = readLine()!.split(separator: " ").compactMap { Int($0) }
    let (N, M) = (NM[0], NM[1])
    
    var edges: [[Edge]] = .init(repeating: [], count: N + 1)
    
    for _ in 0..<M {
        let edge = readLine()!.split(separator: " ").compactMap { Int($0) }
        
        edges[edge[0]].append(Edge(from: edge[0], to: edge[1], cost: edge[2]))
        edges[edge[1]].append(Edge(from: edge[1], to: edge[0], cost: edge[2]))
    }
    
    var heap = MinHeap()
    var isVisted: [Bool] = .init(repeating: false, count: N + 1)
    
    var count = 0
    var totalCost = 0
    var maxCost = Int.min
    
    isVisted[1] = true

    for edge in edges[1] { heap.push(edge) }
    
    while count < N - 1 {
        let edge = heap.pop()
        if isVisted[edge.to] { continue }
        
        isVisted[edge.to] = true
        count += 1
        totalCost += edge.cost
        
        maxCost = max(edge.cost, maxCost)
        
        for e in edges[edge.to]
        where !isVisted[e.to] {
            heap.push(e)
        }
    }
    
    print(totalCost - maxCost)
}
