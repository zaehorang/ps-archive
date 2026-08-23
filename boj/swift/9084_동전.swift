//
// 9084.swift
// Swift_Algorithm
//
// Created by zaehorang on 2026/2/9.
// https://acmicpc.net/problem/9084
//

import Foundation

func _9084() {
    // Your solution here
    let t = Int(readLine()!)!
    var ans = ""

    for _ in 0..<t {
        
        let n = Int(readLine()!)!
        let coins: [Int] = readLine()!.split(separator: " ").compactMap { Int($0)! }
        
        let m = Int(readLine()!)!
        
        var dp: [[Int]] = .init(repeating: .init(repeating: 0, count: m + 1), count: n + 1)
        
        for i in 1...n {
            dp[i][0] = 1
            for j in 1...m {
                if j - coins[i-1] >= 0 {
                    dp[i][j] = dp[i-1][j] + dp[i][j-coins[i-1]]
                } else {
                    dp[i][j] = dp[i-1][j]
                }
            }
        }
        ans += "\(dp[n][m])\n"
    }
    print(ans)
}

func _9084_1() {
    // Your solution here
    let t = Int(readLine()!)!
    var ans = ""

    var dp: [[Int]] = .init(repeating: .init(repeating: 0, count: 10002), count: 22)
    
    for _ in 0..<t {
        let n = Int(readLine()!)!
        let coins: [Int] = readLine()!.split(separator: " ").compactMap { Int($0)! }
        for i in 0..<n { dp[i][0] = 1 }
        let m = Int(readLine()!)!
        
        for i in 0..<n {
            for j in 1...m {
                dp[i][j] = 0
                if i-1 >= 0 {
                    dp[i][j] += dp[i-1][j]
                }
                if j - coins[i] >= 0 {
                    dp[i][j] += dp[i][j - coins[i]]
                }
            }
        }
        ans += "\(dp[n-1][m])\n"
    }
    print(ans)
}


/// 1D DP
func _9084_2() {
    let t = Int(readLine()!)!
    var ans = ""
    
    for _ in 0..<t {
        let _ = Int(readLine()!)!
        let coins: [Int] = readLine()!.split(separator: " ").compactMap { Int($0)! }
        let m = Int(readLine()!)!
        
        var dp: [Int] = .init(repeating: 0, count: m + 1)
        dp[0] = 1
        
        for coin in coins {
            if coin <= m {
                for j in coin...m {
                    dp[j] += dp[j - coin]
                }
            }
        }
        ans += "\(dp[m])\n"
    }
    print(ans)
}
