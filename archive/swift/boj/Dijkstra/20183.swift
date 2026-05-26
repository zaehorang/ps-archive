//
// 20183.swift
// Swift_Algorithm
//
// Created by zaehorang on 2026/1/19.
// https://acmicpc.net/problem/20183
//

/*
 BOJ 20183: 골목 대장

 목표
 - A -> B로 가는 경로 중에서
   1) 경로의 "총 비용 합" <= C 를 만족하고
   2) 그 경로에서 등장하는 "최대 간선 비용"(= 가장 비싼 골목 요금)을 최소화

 핵심 아이디어
 - "최대 간선 비용"을 limit이라고 두고, limit 이하 간선만 사용 가능하다고 가정하면
   -> 그 조건에서 A->B "최소 총 비용"을 다익스트라로 구할 수 있다.
 - 이때 dist[B] <= C 이면 "이 limit으로도 가능".
 - limit이 커질수록 사용할 수 있는 간선이 늘어나므로
   "가능 여부"는 단조성(불가능 -> 가능)을 가진다.
   -> 따라서 limit을 이분 탐색한다.

 주의
 - 다익스트라에서 정답 확정은 "pop" 시점에만 안전하다.
   (이웃에서 B를 발견했다고 중단하면 더 싼 경로가 뒤늦게 나올 수 있음)

 복잡도
 - limit 후보: 간선 비용들의 유니크 정렬 O(M log M)
 - dijkstra(limit): 다익스트라 O((N+M) log N)
 - 이분 탐색: O(log M)
 => 전체 O((N+M) log N log M)
 */

import Foundation

func _20183() {
    // Your solution here
    typealias nodeTuple = (cost: Int, node: Int)
    
    struct MinHeap {
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
    
    let nmabc = readLine()!.split(separator: " ").compactMap { Int($0) }
    let (n, m, a, b, c) = (nmabc[0], nmabc[1], nmabc[2], nmabc[3], nmabc[4])
    
    let INF = Int.max / 4
    
    var grid: [[nodeTuple]] = .init(repeating: [], count: n + 1)
    var allCosts: Set<Int> = []
    
    for _ in 0..<m {
        let abc = readLine()!.split(separator: " ").compactMap { Int($0) }
        let (from, to, cost) = (abc[0], abc[1], abc[2])
        grid[from].append((cost, to))
        grid[to].append((cost, from))
        
        allCosts.insert(cost)
    }
    
    let uniq = allCosts.sorted()
   
    
    func dijkstra(_ limit: Int) -> Bool {
        var dist: [Int] = .init(repeating: INF, count: n + 1)
        dist[a] = 0
        
        var heap = MinHeap()
        heap.push((0, a))
        
        while !heap.isEmpty {
            let cur = heap.pop()
            guard cur.cost == dist[cur.node] else { continue }
            
            if cur.node == b { return cur.cost <= c }
            if cur.cost > c { continue }
                
            for new in grid[cur.node] {
                if new.cost > limit { continue }
                let nd =  new.cost + cur.cost
                
                if dist[new.node] > nd && nd <= c {
                    dist[new.node] = nd
                    heap.push((nd, new.node))
                                    
                    if new.node == b { break }
                }
            }
        }
        
        return dist[b] <= c
    }
    
    if !dijkstra(uniq.last!) {
        print(-1)
        return
    }
    
    var st = 0
    var en = uniq.count - 1
    
    while st < en {
        let mid = (st + en) / 2
        if dijkstra(uniq[mid]) {
            en = mid
        } else {
            st = mid + 1
        }
    }
    print(uniq[en])
}
