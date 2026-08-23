//
//  1956.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 1/10/26.
//  https://www.acmicpc.net/problem/1956

import Foundation

func _1956() {
    let VE = readLine()!.split(separator: " ").compactMap { Int($0) }
    let (V, E) = (VE[0], VE[1])
    
    let INF = Int.max / 2
    
    var route: [[Int]] = .init(repeating: .init(repeating: INF, count: V + 1), count: V + 1)
    
    for _ in 0..<E {
        let abc = readLine()!.split(separator: " ").compactMap { Int($0) }
        let (a, b, c) = (abc[0], abc[1], abc[2])
        
        route[a][b] = c
    }
    
    for i in 1...V { route[i][i] = 0 }
    
    for k in 1...V {
        for i in 1...V {
            for j in 1...V {
                let new = route[i][k] + route[k][j]
                if route[i][j] > new { route[i][j] = new }
            }
        }
    }
    
    var ans = INF
    
    for start in 1...V {
        for end in 1...V where start != end {
            let go = route[start][end]
            let back = route[end][start]
            
            if go >= INF || back >= INF { continue }
            
            ans = min(ans, go + back)
        }
    }
    print(ans >= INF ? -1 : ans)
}
