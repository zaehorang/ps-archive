//
//  1368.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 12/31/25.
//  https://www.acmicpc.net/problem/1368

import Foundation

/*
 이 문제(BOJ 1368)의 핵심은 “프림을 N번 돌리느냐”가 아니라 문제 모델링을 MST로 정확히 바꿨느냐이다.
 아래 첫 프림 풀이는 정확한 MST 모델링과 1:1로 대응되지 않는다.
 
 ✅ “가상의 정점 0”을 추가
 - 정점 1..N = 논
 - 정점 0 = “물을 공급하는 소스(우물을 판다는 선택)”
 */


 /// 해당 방식은 우풀을 직접 파는 경우를 "독립 비용"처럼 계산한 방식
func _1368_first() {
    struct Edge {
        let to: Int
        let cost: Int
    }
    
    struct MinEdgeQueue {
        private var queue: [Edge] = [Edge(to: 0, cost: 0)]
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
    
    let N = Int(readLine()!)!
    var direct = [0]
    (1...N).forEach { _ in direct.append(Int(readLine()!)!) }
    
    var inDirect: [[Int]] = [[]]
    (1...N).forEach { _ in
        var nums = [0]
        
        nums += readLine()!
            .split(separator: " ")
            .compactMap { Int($0) }
        
        inDirect.append(nums)
    }
    
    var bestCost = Int.max
    
    // 시작점 다르게
    for i in 1...N {
        var count = 0
        var cost = 0
        
        var check: [Bool] = .init(repeating: false, count: N + 1)
        check[i] = true
        cost += direct[i]
        
        var pq = MinEdgeQueue()
        
        for j in 1...N {
            pq.push(Edge(to: j, cost: inDirect[i][j]))
            pq.push(Edge(to: j, cost: direct[j]))
        }
        
        while count < N - 1 {
            let topEdge = pq.pop()
            
            if check[topEdge.to] { continue }
            
            cost += topEdge.cost
            count += 1
            check[topEdge.to] = true
            
            for j in 1...N {
                pq.push(Edge(to: j, cost: inDirect[topEdge.to][j]))
            }
        }
        
        bestCost = min(bestCost, cost)
    }
    
    print(bestCost)
}

/// 크루스칼 알고리즘 방식
func _1368_Kruskal() {
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
    
    struct Edge {
        let from: Int
        let to: Int
        let cost: Int
    }
    
    var edges: [Edge] = []
    
    let N = Int(readLine()!)!
    
    (1...N)
        .forEach {
            edges.append(
                Edge(from: $0, to: N + 1, cost: Int(readLine()!)!)
            )
        }
    
    (1...N).forEach { from in
        readLine()!
            .split(separator: " ")
            .compactMap { Int($0) }
            .enumerated()
            .forEach {
                edges.append(
                    Edge(from: from, to: $0 + 1, cost: $1)
                )
            }
    }
    
    edges.sort { $0.cost < $1.cost }
    
    var count = 0
    var totalCost = 0
    var uf = UnionFind(N + 1)
    
    for e in edges {
        if !uf.union(e.from, e.to) { continue }
        totalCost += e.cost
        count += 1
        
        if count == N { break } // 가상의 정점까지 포함 +1
    }
    print(totalCost)
}

/// 프라임 알고리즘
/// 프림의 시작점은 반드시 가상 정점이어야 합니다.
func _1368_Prim() {
    struct Edge {
        let from: Int
        let to: Int
        let cost: Int
    }
    
    struct MinEdgeQueue {
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
    
    let N = Int(readLine()!)!
    let vertexCount = N + 1 // 가상의 점 추가
    var edges: [[Edge]] = .init(repeating: [], count: vertexCount + 1)
    
    (1...N).forEach {
        let cost = Int(readLine()!)!   // ✅ 한 번만 읽기
           edges[$0].append(Edge(from: $0, to: vertexCount, cost: cost))
           edges[vertexCount].append(Edge(from: vertexCount, to: $0, cost: cost))
    }
    
    (1...N).forEach { from in
        readLine()!
            .split(separator: " ")
            .compactMap { Int($0) }
            .enumerated()
            .forEach {
                edges[from].append(Edge(from: from, to: $0 + 1, cost: $1))
            }
    }
    
    var count = 0
    var cost = 0
    
    var check: [Bool] = .init(repeating: false, count: vertexCount + 1)
    
    var pq = MinEdgeQueue()
    
    check[vertexCount] = true   // 가상 정점을 시작점으로
    for e in edges[vertexCount] {
        pq.push(e)
    }

    
    while count < vertexCount - 1 {
        let topEdge = pq.pop()
        
        if check[topEdge.to] { continue }
        
        cost += topEdge.cost
        count += 1
        check[topEdge.to] = true
        
        for e in edges[topEdge.to] {
            pq.push(e)
        }
    }
    
    print(cost)
}
