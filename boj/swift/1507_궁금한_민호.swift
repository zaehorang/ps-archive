//
// 1507.swift
// Swift_Algorithm
//
// Created by zaehorang on 2026/1/12.
// https://acmicpc.net/problem/1507
//

import Foundation

/*
 주어진 행렬은 최단 거리 결과여야 함
 항상 성립:d[i][j] ≤ d[i][k] + d[k][j]
 
 삼각부등식(triangle inequality)은 “직접 가는 길이, 중간을 거쳐 가는 길보다 길 수는 없다”라는 규칙
 
 각 쌍 (i, j)에 대해, 중간 정점 k가 하나라도 있어서
 - d[i][j] == d[i][k] + d[k][j]
 가 성립하면 i -j를 직접 간선으로 둘 필요 없음
 
 양방향이니 합은 i < j 일 때만 값 더하기.
 */

func _1507() {
    let N = Int(readLine()!)!
    
    var route:[[Int]] = []
    
    for _ in 0..<N {
        route.append(readLine()!.split(separator: " ").compactMap { Int($0) })
    }
    
    var ans = 0
    
    for i in 0..<N {
        for j in (i + 1)..<N {
            var isAdd = true
            
            for k in 0..<N {
                if i == k || j == k { continue }
                let new = route[i][k] + route[k][j]
                
                if route[i][j] > new {
                    print(-1)
                    return
                }
                
                if route[i][j] == new {
                    isAdd = false
                    break
                }
            }
            
            if isAdd { ans += route[i][j] }
        }
    }
    print(ans)
}
