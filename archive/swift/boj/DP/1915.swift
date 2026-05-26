//
// 1915.swift
// Swift_Algorithm
//
// Created by zaehorang on 2026/2/10.
// https://acmicpc.net/problem/1915
//

import Foundation

func _1915() {
    // Your solution here
    let nm = readLine()!.split(separator: " ").compactMap { Int($0) }
    let (n, m) = (nm[0], nm[1])
    var table: [[Int]] = []
    for _ in 0..<n {
        table.append(readLine()!.compactMap { Int(String($0)) })
    }
    
    var d: [[Int]] = .init(repeating: .init(repeating: 0, count: m), count: n)
    
    for i in 0..<n { d[i][0] = table[i][0] }
    for j in 0..<m { d[0][j] = table[0][j] }
    
    for i in 1..<n {
        for j in 1..<m {
            if table[i][j] == 0 { continue }
            d[i][j] = min(d[i-1][j], d[i-1][j-1], d[i][j-1]) + 1
        }
    }
    var ans = 0
    for line in d {
        for n in line {
            ans = max(n,  ans)
        }
    }
    print(ans * ans)
}

/*
 - 1차원 dp
 - 바이트 비교
 */
func _1915_1() {
    let nm = readLine()!.split(separator: " ").compactMap { Int($0) }
    let (n, m) = (nm[0], nm[1])

    var dp = [Int](repeating: 0, count: m)
    var ans = 0

    for i in 0..<n {
        let line = Array(readLine()!.utf8) // '0'/'1' 문자 바이트
        var prevDiag = 0

        for j in 0..<m {
            let up = dp[j]          // 갱신 전 dp[j]는 "위"
            if line[j] == Character("1").asciiValue! {   // '1'의 ASCII = 49
                if i == 0 || j == 0 {
                    dp[j] = 1
                } else {
                    let left = dp[j - 1]
                    let diag = prevDiag
                    dp[j] = min(left, up, diag) + 1
                }
                if dp[j] > ans { ans = dp[j] }
            } else {
                dp[j] = 0
            }
            prevDiag = up
        }
    }

    print(ans * ans)
}
