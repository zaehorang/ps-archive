//
//  1181.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 12/27/25.
//  https://www.acmicpc.net/problem/1181

import Foundation

/*
 1 <= N <= 20,000
 1 <= 문자열 길이(L) <= 50
 
중복 제거: Set에 N번 insert
 - insert는 평균적으로 O(1) (Hash Function에 좌우, 문자열 길이에 비례하는 해시/비교 비용)
 - 중복 제거는 대략 O(N * L)
 
 정렬 대상은 중복 제거된 M개
 - O(M log M)
    - 문자열 길이 비교는 O(L)
 - 대략적으로 정렬은 O(M log M * L)
 */

func _1181() {
    let N = Int(readLine()!)!
    
    var stringSet: Set<String> = []
    
    for _ in 0..<N { stringSet.insert(readLine()!) }
    
    let ans = stringSet.sorted {
        if $0.count < $1.count {
            return true
        } else if $0.count == $1.count {
            if $0 < $1 { return true }
        }
        return false
    }.joined(separator: "\n")
    
    print(ans)
}

func _1181_optimize() {
    let N = Int(readLine()!)!
    
    var unique: Set<String> = []
    
    for _ in 0..<N { unique.insert(readLine()!) }
    
    let sorted = unique.sorted { a, b in
        let aLen = a.count
        let bLen = b.count
        
        if aLen != bLen { return aLen < bLen }
        return a < b
    }
    
    print(sorted.joined(separator: "\n"))
}
