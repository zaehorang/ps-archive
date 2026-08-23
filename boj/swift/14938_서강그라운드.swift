//
//  14938.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 1/7/26.
//  https://www.acmicpc.net/problem/14938

import Foundation

func _14938() {
    let nmr = readLine()!.split(separator: " ").compactMap { Int($0) }
    let (n, m, r) = (nmr[0], nmr[1], nmr[2])
    
    let item: [Int] = [0] + readLine()!.split(separator: " ").compactMap { Int($0) }
    
    let INF = Int.max / 2
    
    var route: [[Int]] = .init(repeating: .init(repeating: INF, count: n + 1), count: n + 1)
    for _ in 0..<r {
        let r = readLine()!.split(separator: " ").compactMap { Int($0) }
        let (a, b, l) = (r[0], r[1], r[2])
        
        route[a][b] = l
        route[b][a] = l
    }
    
    for i in 1...n { route[i][i] = 0 }
    
    for k in 1...n {
        for i in 1...n {
            for j in 1...n {
                let new = route[i][k] + route[k][j]
                if route[i][j] > new { route[i][j] = new }
            }
        }
    }
    
    var ans = Int.min
    
    for i in 1...n {
        var count = 0
        for j in 1...n {
            if route[i][j] <= m { count += item[j] }
        }
        
        ans = max(ans, count)
    }
    print(ans)
}
