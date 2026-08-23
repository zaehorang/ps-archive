//
// 1504.swift
// Swift_Algorithm
//
// Created by zaehorang on 2026/1/16.
// https://acmicpc.net/problem/1504
//

import Foundation

/*
 경로가 없을 수 있는 조건 확인: -1 출력
 */

func _1504() {
    // Your solution here
    typealias nodeTuple = (node: Int, cost: Int)
    
    struct MinCostHeap {
        private var table: [nodeTuple] = [(0, 0)]
        private var count = 0
        
        private var areSorted: (nodeTuple, nodeTuple) -> Bool = {
            $0.cost < $1.cost
        }
        var isEmpty: Bool { count == 0 }
        
        mutating func push(_ n: nodeTuple) {
            table.append(n)
            count += 1
            
            var index = count
            
            while index != 1 {
                let parentIdx = index / 2
                if areSorted(table[parentIdx], table[index]) { break }
                
                table.swapAt(index, parentIdx)
                index = parentIdx
            }
        }
        
        mutating func pop() -> nodeTuple {
            guard count != 0 else { return table[0] }
            let min = table[1]
            table[1] = table[count]
            table.removeLast()
            count -= 1
            
            var index = 1
            
            while index * 2 <= count {
                let leftChildIdx = index * 2
                let rightChildIdx = index * 2 + 1
                
                var targetChildIdx = leftChildIdx
                
                if rightChildIdx <= count,
                   areSorted(table[rightChildIdx], table[leftChildIdx]) {
                    targetChildIdx = rightChildIdx
                }
                
                if areSorted(table[index], table[targetChildIdx]) { break }
                
                table.swapAt(index, targetChildIdx)
                index = targetChildIdx
            }
            
            return min
        }
        
    }
    
    
    let ne = readLine()!.split(separator: " ").compactMap { Int($0) }
    let(n, e) = (ne[0], ne[1])
    
    var route: [[nodeTuple]] = .init(repeating: [], count: n + 1)
    
    for _ in 0..<e {
        let abc = readLine()!.split(separator: " ").compactMap { Int($0) }
        let(a, b, c) = (abc[0], abc[1], abc[2])
        
        route[a].append((b, c))
        route[b].append((a, c))
    }
    
    let INF = Int.max / 4
    
    func dijkstra(_ start: Int) -> [Int] {
        var dist: [Int] = .init(repeating: INF, count: n + 1)
        dist[start] = 0
        
        var heap = MinCostHeap()
        heap.push((start, 0))
        
        while !heap.isEmpty {
            let current = heap.pop()
            
            guard dist[current.node] == current.cost else { continue }
            
            for next in route[current.node] {
                if dist[next.node] > dist[current.node] + next.cost {
                    dist[next.node] = dist[current.node] + next.cost
                    heap.push((next.node, dist[next.node]))
                }
            }
        }
        
        return dist
    }
    
    let v1v2 = readLine()!.split(separator: " ").compactMap { Int($0) }
    let (v1, v2) = (v1v2[0], v1v2[1])
    
    let distFromV1 = dijkstra(v1)
    let distFromV2 = dijkstra(v2)
    
    let bestDist = min(
        distFromV1[1] + distFromV1[v2] + distFromV2[n], // 1 -> v1 -> v2 -> n
        distFromV2[1] + distFromV2[v1] + distFromV1[n]  // 1 -> v2 -> v1 -> n
    )
    
    guard bestDist < INF else {
        print(-1)
        return
    }
    
    print(bestDist)
}
