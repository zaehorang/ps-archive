//
// 11779.swift
// Swift_Algorithm
//
// Created by zaehorang on 2026/1/14.
// https://acmicpc.net/problem/11779
//

import Foundation

func _11779() {
    // Your solution here
    struct MinHeap {
        var arr = [(0, 0)] // (정점, dist)
        var count = 0
        
        var areSorted: ((Int, Int), (Int, Int)) -> Bool = { $0.1 < $1.1 }
        var isEmpty: Bool { count == 0 ? true : false }
        
        mutating func push(_ n: (Int, Int)) {
            arr.append(n)
            count += 1
            
            var index = count
            
            while index != 1 {
                let parentIdx = index / 2
                
                if areSorted(arr[parentIdx], n) { break }
                
                arr.swapAt(parentIdx, index)
                index = parentIdx
            }
        }
        
        mutating func pop() -> (Int, Int) {
            let min = arr[1]
            arr[1] = arr[count]
            arr.removeLast()
            count -= 1
            
            var index = 1
            
            while index * 2 <= count {
                let leftChildIdx = index * 2
                let rightChildIdx = index * 2 + 1
                
                var targetChildIdx = leftChildIdx
                
                if rightChildIdx <= count,
                   areSorted(arr[rightChildIdx], arr[leftChildIdx]) {
                    targetChildIdx = rightChildIdx
                }
                
                if areSorted(arr[index], arr[targetChildIdx]) { break }
                
                arr.swapAt(index, targetChildIdx)
                index = targetChildIdx
            }
            
            return min
        }
    }
    
    let n = Int(readLine()!)!
    let m = Int(readLine()!)!
    
    var route: [[(Int, Int)]] = .init(repeating: [], count:n + 1)
    
    for _ in 0..<m {
        let abc = readLine()!.split(separator: " ").compactMap { Int($0) }
        let (a, b, c) = (abc[0], abc[1], abc[2])
        
        route[a].append((b, c))
    }
    
    
    let se = readLine()!.split(separator: " ").compactMap { Int($0) }
    let (start, end) = (se[0], se[1])
    
    let INF = Int.max / 4
    
    var dist: [Int] = .init(repeating: INF, count: n + 1)
    var pre: [Int] = .init(repeating: INF, count: n + 1)
    
    dist[start] = 0
    pre[start] = start
    
    var heap = MinHeap()
    heap.push((start, 0))
    
    while !heap.isEmpty {
        let current = heap.pop()
        guard dist[current.0] == current.1 else { continue }
        
        for next in route[current.0] {
            if next.1 + current.1 < dist[next.0] {
                dist[next.0] = next.1 + current.1
                heap.push((next.0, dist[next.0]))
                pre[next.0] = current.0
            }
        }
    }
    
    var ans = ""
    ans += "\(dist[end])\n"
    
    var reversedRoute = [end]
    var routeCnt = 1
    
    var idx = end
    while idx != start {
        idx = pre[idx]
        reversedRoute.append(idx)
        routeCnt += 1
    }
    
    ans += "\(routeCnt)\n" + reversedRoute.reversed().compactMap { String($0) }.joined(separator: " ")
    
    print(ans)
}
