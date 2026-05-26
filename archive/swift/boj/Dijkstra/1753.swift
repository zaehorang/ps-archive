//
// 1753.swift
// Swift_Algorithm
//
// Created by zaehorang on 2026/1/14.
// https://acmicpc.net/problem/1753
//

import Foundation

func _1753() {
    struct MinDistHeap {
        // (정점, dist)
        var arr: [(Int, Int)] = [(0, 0)]
        var count = 0
        var isEmpty: Bool { count == 0 ? true : false }
        
        var areSorted: ((Int, Int), (Int,Int)) -> Bool = {
            $0.1 < $1.1
        }
        
        mutating func push(_ n: (Int, Int)) {
            arr.append(n)
            count += 1
            
            var index = count
            
            while index != 1 {
                let parentIndex = index / 2
                if areSorted(arr[parentIndex], n) { break }
                
                arr.swapAt(parentIndex, index)
                index = parentIndex
            }
            
        }
        
        mutating func pop() -> (Int, Int) {
            let top = arr[1]
            arr[1] = arr[count]
            arr.removeLast()
            count -= 1
            
            var index = 1
            
            while index * 2 <= count {
                let leftChildIndex = index * 2
                let rightChildIndex = index * 2 + 1
                
                var targetChildIndex = leftChildIndex
                
                if rightChildIndex <= count,
                   areSorted(arr[rightChildIndex], arr[leftChildIndex]) {
                    targetChildIndex = rightChildIndex
                }
                
                if areSorted(arr[index], arr[targetChildIndex]) { break }
                
                arr.swapAt(index, targetChildIndex)
                index = targetChildIndex
            }
            
            return top
        }
    }
    
    let VE = readLine()!.split(separator: " ").compactMap { Int($0) }
    let (V, E) = (VE[0], VE[1])
    
    var graph: [[(Int, Int)]] = .init(repeating: [], count: V + 1)
    
    let start = Int(readLine()!)!
    
    for _ in 0..<E {
        let uvw = readLine()!.split(separator: " ").compactMap { Int($0) }
        let (u, v, w) = (uvw[0], uvw[1], uvw[2])
        
        graph[u].append((v, w))
    }
    
    let INF = Int.max / 4
    
    var dist: [Int] = .init(repeating: INF, count: V + 1)
    
    var heap = MinDistHeap()
    dist[start] = 0
    heap.push((start, 0))
    
    while !heap.isEmpty {
        let (v, d) = heap.pop()
        guard dist[v] == d else { continue }
        
        
        for (newV, newD) in graph[v] {
            if dist[newV] <= dist[v] + newD { continue }
            dist[newV] = dist[v] + newD
            heap.push((newV, dist[newV]))
        }
    }
    
    var ans = ""
    
    for i in dist[1...V] {
        if i == INF {
            ans += "INF\n"
        } else {
            ans += "\(i)\n"
        }
    }
    print(ans)
}
