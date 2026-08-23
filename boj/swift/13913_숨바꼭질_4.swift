//
// 13913.swift
// Swift_Algorithm
//
// Created by zaehorang on 2026/3/1.
// https://acmicpc.net/problem/13913
//

import Foundation

func _13913() {
    // Your solution here
    
    let nk = readLine()!.split(separator: " ").compactMap { Int($0) }
    let (n, k) = (nk[0], nk[1])

    if n >= k {
        print(n - k)
        let route = (k...n).reversed()
            .map { String($0) }
            .joined(separator: " ")
        print(route)
        return
    }

    let MAX = 100000
    
    var dist = Array(repeating: -1, count: MAX + 1)
    var before = Array(repeating: -1, count: MAX + 1)
    
    var queue = [n]
    var head = 0
    
    dist[n] = 0
    before[n] = -1
    
    while head < queue.count {
        let cur = queue[head]
        head += 1
        
        guard cur != k else {
            print(dist[cur])
            
            var route: [Int] = []
            var r = cur
            while r != -1 {
                route.append(r)
                r = before[r]
            }
            
            print(
                route.reversed()
                    .map { String($0) }
                    .joined(separator: " ")
            )
            return
        }
        
        let nextCandidates = [cur - 1, cur + 1, cur * 2]
        for next in nextCandidates {
            guard next >= 0 && next <= MAX else { continue }
            
            if dist[next] == -1 {
                before[next] = cur
                dist[next] = dist[cur] + 1
                queue.append(next)
            }
        }
    }
}
