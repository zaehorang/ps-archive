//
// 1261.swift
// Swift_Algorithm
//
// Created by zaehorang on 2026/1/17.
// https://acmicpc.net/problem/1261
//

import Foundation

/*
 [BOJ 1261: 알고리즘별 접근 정리 — Stack vs 0-1 BFS vs Dijkstra]

 이 문제는 각 이동의 비용이 0 또는 1인 "가중치 그래프 최단거리 문제"이다.
 핵심 차이는 자료구조 자체보다도, "어떤 순서로 정점을 꺼내 확장하느냐"에 있다.

 --------------------------------------------------
 1) _1261() : 단순 Stack(LIFO) 기반 완화
 --------------------------------------------------
 - dist가 갱신되면 스택에 push, pop은 LIFO 방식
 - dist가 작은 정점부터 처리된다는 보장이 전혀 없음
 - 나중에 더 좋은(dist가 더 작은) 경로가 발견되면,
   이미 처리했던 칸도 다시 스택에 들어가 재확장됨
 - 같은 칸/간선이 여러 번 재방문(재완화)될 수 있어 실행량이 커질 수 있음
 - 정렬/우선순위 없이 반복 완화를 수행하는 SPFA 유사 구조
 → 입력에 따라 시간 초과가 발생할 수 있음

 --------------------------------------------------
 2) _1261_DQ() : 0-1 BFS (Deque 아이디어)
 --------------------------------------------------
 - 가중치가 0인 간선: front에 넣어 즉시 처리
 - 가중치가 1인 간선: back에 넣어 나중에 처리
 - 결과적으로 dist가 작은 상태부터 처리되는 효과가 생김
 - 불필요한 재방문/재완화가 크게 줄어듦
 - 0/1 가중치에 특화된 다익스트라 최적화 버전
 - 시간 복잡도: O(V + E)
 → 이 문제에서 가장 효율적인 풀이
 
 - 직관(중요):
   Stack 방식은 "최소 비용부터 처리"가 보장되지 않아서,
   더 좋은 길이 존재하더라도(혹은 곧 발견되더라도) 비싼 경로를 먼저 확장할 수 있음.
   그리고 나중에 dist가 더 좋아지면 그 칸은 다시 갱신되어 재확장되므로
   "안 좋은 길로 굳이 들어가는" 낭비가 여러 번 누적되어 느려질 수 있다.
   반대로 0-1 BFS는 0비용 이동을 앞에 두어, 싼 경로부터 처리되게 만들어 이런 낭비를 줄인다.

 --------------------------------------------------
 3) _1261_Dijkstra() : 다익스트라 알고리즘
 --------------------------------------------------
 - "현재까지 비용이 가장 작은 칸"부터 확정해 나감
 - 우선순위 큐(최소 힙)를 사용
 - 동일한 칸이 여러 번 큐에 들어갈 수 있으므로,
   pop 시점에 `cost == dist[x][y]` 체크로 최신 상태만 처리
 - 일반적인 양의 가중치 그래프까지 확장 가능한 범용 풀이
 - 시간 복잡도: O(E log V)

 --------------------------------------------------
 결론
 --------------------------------------------------
 - 세 풀이 모두 '최단거리 완화'라는 점에서는 로직이 유사해 보이지만,
   실제 성능 차이는 "정점을 처리하는 순서"에서 발생한다.
 - Stack 방식: 순서 보장 없음 → 재처리 폭증 가능
 - 0-1 BFS: 0/1 가중치 특성 활용 → dist 오름차순 처리 보장
 - Dijkstra: 우선순위 큐로 dist 최소값부터 확정
 → 이 문제에서는 0-1 BFS가 가장 단순하고 빠른 해법이다.
 */

func _1261() {
    // Your solution here1
    let NM = readLine()!.split(separator: " ").compactMap { Int($0) }
    let (v, h) = (NM[0], NM[1])
    
    var table = [[Int]]()
    var route: [[Int]] = .init(repeating: .init(repeating: Int.max / 4, count: v), count: h)
    
    for _ in 0..<h {
        table.append(readLine()!.compactMap { Int(String($0)) })
    }
    
    var stack: [(Int, Int)] = [(0, 0)]
    let dx = [1, 0, -1, 0]
    let dy = [0, -1, 0, 1]
    
    route[0][0] = 0
    
    while !stack.isEmpty {
        let (x, y) = stack.removeLast()
        
        for i in 0..<4 {
            let nx = x + dx[i]
            let ny = y + dy[i]
            
            guard nx < h && ny < v else { continue }
            guard nx >= 0 && ny >= 0 else { continue }
            
            let w = table[nx][ny]
            
            if route[nx][ny] > route[x][y] + w {
                route[nx][ny] = route[x][y] + w
                stack.append((nx, ny))
            }
        }
    }
    print(route[h-1][v-1])
}

func _1261_DQ() {
    // Your solution here1
    let mn = readLine()!.split(separator: " ").compactMap { Int($0) }
    let (v, h) = (mn[0], mn[1])
    
    var grid = [[Int]]()
    let INF = Int.max / 4
    var dist: [[Int]] = .init(repeating: .init(repeating: INF, count: v), count: h)
    
    for _ in 0..<h {
        grid.append(readLine()!.compactMap { Int(String($0)) })
    }
    
    dist[0][0] = 0
    
    var front: [(Int, Int)] = [(0, 0)]
    var back: [(Int, Int)] = []
    
    let dx = [1, 0, -1, 0]
    let dy = [0, -1, 0, 1]
    
    while !front.isEmpty || !back.isEmpty {
        var (x, y): (Int, Int)
        if !front.isEmpty {
            (x, y) = front.removeLast()
        } else {
            front = back.reversed()
            back = []
            (x, y) = front.removeLast()
        }
        
        for i in 0..<4 {
            let nx = x + dx[i]
            let ny = y + dy[i]
            
            guard nx < h && nx >= 0 else { continue }
            guard ny < v && ny >= 0 else { continue }
            
            let w = grid[nx][ny]
            let nd = dist[x][y] + w
            
            if nd < dist[nx][ny] {
                dist[nx][ny] = nd
                
                if w == 0 {
                    front.append((nx, ny))
                } else {
                    back.append((nx, ny))
                }
            }
        }
    }
    print(dist[h-1][v-1])
}

/// 다익스트라는 "현재까지 비용이 가장 작은 칸"부터 확정해 나간다.
func _1261_Dijkstra() {
    typealias nodeTuple = (cost: Int, a: Int, b: Int)
    
    struct MinCostHeap {
        private var table: [nodeTuple] = [(0, 0, 0)]
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
    
    let mn = readLine()!.split(separator: " ").compactMap { Int($0) }
    let (v, h) = (mn[0], mn[1])
    
    var grid = [[Int]]()
    let INF = Int.max / 4
    var dist: [[Int]] = .init(repeating: .init(repeating: INF, count: v), count: h)
    
    for _ in 0..<h {
        grid.append(readLine()!.compactMap { Int(String($0)) })
    }
    
    var heap = MinCostHeap()
    heap.push((0, 0, 0))
    dist[0][0] = 0
    
    let dx = [1, 0, -1, 0]
    let dy = [0, -1, 0, 1]
    
    while !heap.isEmpty {
        let (c, a, b) = heap.pop()
        
        guard c == dist[a][b] else { continue }
        
        if a == h - 1 && b == v - 1 {
            print(c)
            return
        }
        for i in 0..<4 {
            let nx = a + dx[i]
            let ny = b + dy[i]
            
            guard nx < h && ny < v else { continue }
            guard nx >= 0 && ny >= 0 else { continue }
            
            let w = grid[nx][ny]
            let nd = c + w
            
            if nd < dist[nx][ny] {
                dist[nx][ny] = nd
                heap.push((nd, nx, ny))
            }
        }
    }
    print(dist[h-1][v-1])
}
