//
// 11562.swift
// Swift_Algorithm
//
// Created by zaehorang on 2026/1/11.
// https://acmicpc.net/problem/11562
//

import Foundation

/*
 route[a][b]의 값 = a → b로 가기 위해 “양방향으로 바꿔야 하는 단방향 다리의 최소 개수”
 입력 u v b에 대해:
    - u → v는 원래 가능하므로 route[u][v] = 0
    - b == 1 (원래 양방향) 이면 route[v][u] = 0
    - b == 0 (원래 단방향 u→v) 인데 v → u로 가려면 그 다리를 양방향으로 바꿔야 하므로 route[v][u] = 1
 
 다리를 양방향으로 바꾸는 비용을 edge의 cost로 생각하고 플로이드-워셜 알고리즘으로 비용 계산
 */

func _11562() {
    let nm = readLine()!.split(separator: " ").compactMap { Int($0) }
    let (n, m) = (nm[0], nm[1])
    
    let INF = Int.max / 4
    
    var route: [[Int]] = .init(repeating: .init(repeating: INF, count: n + 1), count: n + 1)
    
    for _ in 0..<m {
        let uvb = readLine()!.split(separator: " ").compactMap { Int($0) }
        let (u, v, b) = (uvb[0], uvb[1], uvb[2])
        
        route[u][v] = 0
        if b == 1 {
            route[v][u] = 0
        } else {
            route[v][u] = 1
        }
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
    
    let k = Int(readLine()!)!
    
    var ans = ""
    
    for _ in 0..<k {
        let se = readLine()!.split(separator: " ").compactMap { Int($0) }
        let (s, e) = (se[0], se[1])
        ans += "\(route[s][e])\n"
    }
    
    print(ans)
}
