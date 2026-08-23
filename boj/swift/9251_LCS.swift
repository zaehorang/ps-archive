//
// 9251.swift
// Swift_Algorithm
//
// Created by zaehorang on 2026/2/8.
// https://acmicpc.net/problem/9251
//

import Foundation

func _9251() {
    // Your solution here
    let a = Array(readLine()!)
    let b = Array(readLine()!)
    
    var table: [[Int]] = .init(repeating: .init(repeating: 0, count: b.count + 1), count: a.count + 1)
    
    for i in 1...a.count {
        for j in 1...b.count {
            if a[i-1] == b[j-1] {
                table[i][j] = table[i-1][j-1] + 1
            }
            table[i][j] = max(table[i][j], table[i-1][j], table[i][j-1])
        }
    }
    print(table[a.count][b.count])
}

/*
 1차원 DP
 - 위: dp[i-1][j]
 - 왼: dp[i][j-1]
 -  대각: dp[i-1][j-1]
 즉, “이전 행 1줄”만 기억하면 다음 행을 만들 수 있다.
 */
func _9251_1() {
    let A = Array(readLine()!)
    let B = Array(readLine()!)

    var dp = [Int](repeating: 0, count: B.count + 1)

    for i in 1...A.count {
        var prev = 0              // dp[i-1][j-1]
        for j in 1...B.count {
            let temp = dp[j]      // dp[i-1][j] 백업
            if A[i-1] == B[j-1] {
                dp[j] = prev + 1
            } else {
                dp[j] = max(dp[j], dp[j-1])
            }
            prev = temp
        }
    }

    print(dp[B.count])
}
