//
// 1238.swift
// Swift_Algorithm
//
// Created by zaehorang on 2026/1/15.
// https://acmicpc.net/problem/1238
//

import Foundation

/// 플로이드 알고리즘: O(n^3)
func _1238() {
    // Your solution here
    let nmx = readLine()!.split(separator: " ").compactMap { Int($0) }
    let (n, m, x) = (nmx[0], nmx[1], nmx[2])
    
    let INF = Int.max / 4
    var route: [[Int]] = .init(repeating: .init(repeating: INF, count: n + 1), count: n + 1)
    for i in 1...n { route[i][i] = 0 }
    
    for _ in 0..<m {
        let abc = readLine()!.split(separator: " ").compactMap { Int($0) }
        let (a, b, c) = (abc[0], abc[1], abc[2])
        route[a][b] = c
    }
    
    /// 플로이드 알고리즘
    for k in 1...n {
        for i in 1...n {
            for j in 1...n {
                if route[i][j] > route[i][k] + route[k][j] {
                    route[i][j] = route[i][k] + route[k][j]
                }
            }
        }
    }
    
    var ans = Int.min
    
    for i in 1...n where i != x {
        let new = route[i][x] + route[x][i]
        guard new < INF else { continue }
        ans = max(ans, new)
    }
    print(ans)
}


/// 다익스트라 알고리즘: O(n log n) / 해당 문제는 O(n^2 log n)
func _1238_1() {
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
    
    
    // Your solution here
    let nmx = readLine()!.split(separator: " ").compactMap { Int($0) }
    let (n, m, x) = (nmx[0], nmx[1], nmx[2])
    
    var route: [[(Int, Int)]] = .init(repeating: [], count: n + 1)
    
    for _ in 0..<m {
        let abc = readLine()!.split(separator: " ").compactMap { Int($0) }
        let (a, b, c) = (abc[0], abc[1], abc[2])
        route[a].append((b, c))
    }
    
    let INF = Int.max / 4
    
    var xDist: [Int] = .init(repeating: INF, count: n + 1)
    var xHeap = MinDistHeap()
    xDist[x] = 0
    xHeap.push((x, 0))
    
    while !xHeap.isEmpty {
        let cur = xHeap.pop()
        guard cur.1 == xDist[cur.0] else { continue }
        
        for next in route[cur.0] {
            if next.1 + cur.1 < xDist[next.0] {
                xDist[next.0] = next.1 + cur.1
                xHeap.push((next.0, xDist[next.0]))
            }
        }
    }
    
    var ans = Int.min
    
    for i in 1...n where i != x {
        var dist: [Int] = .init(repeating: INF, count: n + 1)
        var heap = MinDistHeap()
        dist[i] = 0
        heap.push((i, 0))
        
        while !heap.isEmpty {
            let cur = heap.pop()
            guard cur.1 == dist[cur.0] else { continue }
            
            for next in route[cur.0] {
                if next.1 + cur.1 < dist[next.0] {
                    dist[next.0] = next.1 + cur.1
                    heap.push((next.0, dist[next.0]))
                }
            }
        }
        
        ans = max(ans, dist[x] + xDist[i])
    }
    print(ans)
}

/*
 ⭐️ 핵심 아이디어 (역방향 그래프)
 - 원본 그래프는 단방향이라서, 원본에서 i → X로 갈 수 있어도 X → i로는 못 갈 수 있다.
 - 여기서 “i → X를 X → i로 바꾼다”는 뜻은
   원본 그래프에서 방향을 바꾸는 게 아니라,
   모든 간선 방향을 뒤집어 만든 ‘역방향 그래프’에서 X를 시작점으로 본다는 의미다.

 ✅ 성질
 - 원본 그래프에서의 최단거리(i → X)
   = 역방향 그래프에서의 최단거리(X → i)

 ✅ 이유
 원본에서 어떤 경로가 있다고 하자:
   - 원본 경로: i → a → b → X   (시간: w1 + w2 + w3)

 역방향 그래프는 모든 간선을 뒤집었으므로, 같은 간선들이 반대 방향으로 존재한다:
   - 역방향 경로: X → b → a → i (시간: w3 + w2 + w1)

 이 경로는 원본 경로를 “거꾸로 따라간 것”이며,
 사용하는 간선과 가중치가 동일하므로 총 비용(시간)도 동일하다.

 따라서 i에서 X로 가는 값을 학생마다 따로 구하지 않고,
 역방향 그래프에서 X 시작 다익스트라 1번으로 모든 i의 (i → X) 값을 한 번에 구할 수 있다.
*/

func _1238_opt() {
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
    
    // Your solution here
    let nmx = readLine()!.split(separator: " ").compactMap { Int($0) }
    let (n, m, x) = (nmx[0], nmx[1], nmx[2])
    
    var route: [[(Int, Int)]] = .init(repeating: [], count: n + 1)
    var reversedRoute: [[(Int, Int)]] = .init(repeating: [], count: n + 1)
    
    for _ in 0..<m {
        let abc = readLine()!.split(separator: " ").compactMap { Int($0) }
        let (a, b, c) = (abc[0], abc[1], abc[2])
        route[a].append((b, c))
        reversedRoute[b].append((a, c))
    }
    
    let INF = Int.max / 4
    
    func dijkstra(_ start: Int, graph: [[(Int, Int)]]) -> [Int] {
        var dist: [Int] = .init(repeating: INF, count: n + 1)
        var heap = MinDistHeap()
        dist[x] = 0
        heap.push((x, 0))
        
        while !heap.isEmpty {
            let cur = heap.pop()
            guard cur.1 == dist[cur.0] else { continue }
            
            for next in graph[cur.0] {
                if next.1 + cur.1 < dist[next.0] {
                    dist[next.0] = next.1 + cur.1
                    heap.push((next.0, dist[next.0]))
                }
            }
        }
        
        return dist
    }

    let distFromX = dijkstra(x, graph: route)
    let distToX = dijkstra(x, graph: reversedRoute)
    
    var ans = Int.min
    
    for i in 1...n where i != x {
        ans = max(ans, distFromX[i] + distToX[i])
    }
    print(ans)
}
