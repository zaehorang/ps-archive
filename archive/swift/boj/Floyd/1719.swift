//
// 1719.swift
// Swift_Algorithm
//
// Created by zaehorang on 2026/1/13.
// https://acmicpc.net/problem/1719
//

import Foundation

func _1719() {
    let nm = readLine()!.split(separator:" ").compactMap { Int($0) }
    let (n, m) = (nm[0], nm[1])
    
    let INF = Int.max / 4
    var route: [[Int]] = .init(repeating: .init(repeating: INF, count: n + 1), count: n + 1)
    var next: [[Int]] = .init(repeating: .init(repeating: 0, count: n + 1), count: n + 1)
    
    for i in 1...n { route[i][i] = 0 }
    
    for _ in 1...m {
        let abc = readLine()!.split(separator:" ").compactMap { Int($0) }
        let (a, b, c) = (abc[0] , abc[1], abc[2])
        route[a][b] = c
        route[b][a] = c
        
        next[a][b] = b
        next[b][a] = a
    }
    
    for k in 1...n {
        for i in 1...n {
            for j in 1...n {
                if route[i][k] == INF || route[k][j] == INF { continue }
                let new = route[i][k] + route[k][j]
                if route[i][j] > new {
                    route[i][j] = new
                    next[i][j] = next[i][k]
                }
            }
        }
    }
    
    var ans = ""
    
    for i in 1...n {
        var str = next[i][1...n].map { String($0) }
        str[i - 1] = "-"
        ans += "\(str.joined(separator: " "))\n"
    }
    print(ans)
}
