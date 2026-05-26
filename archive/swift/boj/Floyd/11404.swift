//
//  11404.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 1/5/26.
//  https://www.acmicpc.net/problem/11404

import Foundation

func _11404() {
    let N = Int(readLine()!)!
    let M = Int(readLine()!)!
    
    let INF = Int.max / 2
    
    var route: [[Int]] = .init(repeating: .init(repeating: INF, count: N + 1), count: N + 1)
    
    for _ in 0..<M {
        let abc = readLine()!.split(separator: " ").compactMap { Int($0) }
        let (a, b ,c) = (abc[0], abc[1], abc[2])
        
        route[a][b] = min(c, route[a][b])
    }
    
    for i in 1...N { route[i][i] = 0 }
    
    for k in 1...N {
        for i in 1...N {
            for j in 1...N {
                let new = route[i][k] + route[k][j]
                if route[i][j] > new { route[i][j] = new }
            }
        }
    }
    
    var ans = ""
    
    for i in 1...N {
        for j in 1...N {
            let cost = route[i][j] < INF ? route[i][j] : 0
            
            ans += "\(cost) "
        }
        ans += "\n"
    }
    
    print(ans)
}
