//
//  9372.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 1/2/26.
//  https://www.acmicpc.net/problem/9372

import Foundation

/*
 연결 그래프에서 모든 정점을 방문하는 최소 간선의 수는 (정점 수 - 1)
 */

func _9372() {
    let T = Int(readLine()!)!
    
    for _ in 0..<T {
        let NM = readLine()!.split(separator: " ").compactMap { Int($0) }
        let (N, M) = (NM[0], NM[1])
        
        for _ in 0..<M {
            let _ = readLine()!
        }
        print(N - 1)
    }
}
