//
// 1916.swift
// Swift_Algorithm
//
// Created by zaehorang on 2026/1/20.
// https://acmicpc.net/problem/1916
//

import Foundation

func _1916() {
    // Your solution here
    typealias Edge = (to: Int, cost: Int)
    
    struct minCostHeap {
        private var arr = [(0, 0)]
        private var count = 0
        var isEmpty: Bool { count == 0 }
        private var areSorted: (Edge, Edge) -> Bool = {
            $0.cost < $1.cost
        }
        
        mutating func push(_ n: Edge) {
            arr.append(n)
            count += 1
            
            var index = count
            
            while index != 1 {
                let parentIdx = index / 2
                
                if areSorted(arr[parentIdx], arr[index]) { break }
                arr.swapAt(parentIdx, index)
                index = parentIdx
            }
        }
        
        mutating func pop() -> Edge {
            let min = arr[1]
            arr[1] = arr.last!
            arr.removeLast()
            count -= 1
            
            var index = 1
            
            while index * 2 <= count {
                let leftChildIdx = index * 2
                let rightChildIdx = index * 2 + 1
                
                var targetChildIdx = leftChildIdx
                
                if rightChildIdx <= count, areSorted(arr[rightChildIdx], arr[leftChildIdx]) {
                    targetChildIdx = rightChildIdx
                }
                if areSorted(arr[index], arr[targetChildIdx]) { break }
                
                arr.swapAt(targetChildIdx, index)
                
                index = targetChildIdx
            }
            
            return min
        }
    }
    
    let n = Int(readLine()!)!
    let m = Int(readLine()!)!
    
    var graph: [[Edge]] = .init(repeating: [], count: n + 1)
    
    for _ in 0..<m {
        let abc = readLine()!.split(separator: " ").compactMap { Int($0) }
        let (a, b, c) = (abc[0], abc[1], abc[2])
        graph[a].append((b, c))
    }
    
    let se = readLine()!.split(separator: " ").compactMap { Int($0) }
    let (start, end) = (se[0], se[1])
    
    let INF = Int.max / 4
    
    var heap = minCostHeap()
    var dist: [Int] = .init(repeating: INF, count: n + 1)
    
    heap.push((start, 0))
    dist[start] = 0
    
    while !heap.isEmpty {
        let cur = heap.pop()
        guard cur.cost == dist[cur.to] else { continue }
        if cur.to == end { break }
        
        for next in graph[cur.to] {
            let w = next.cost
            let nd = w + cur.cost
            
            if nd < dist[next.to] {
                dist[next.to] = nd
                heap.push((next.to, nd))
            }
        }
    }
    print(dist[end])
}
