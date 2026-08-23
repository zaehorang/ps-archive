//
// 7579.swift
// Swift_Algorithm
//
// Created by zaehorang on 2026/3/24.
// https://acmicpc.net/problem/7579
//

import Foundation

func _7579() {
    // Your solution here
    let nm = readLine()!.split(separator: " ").compactMap { Int($0) }
    let (n, m) = (nm[0], nm[1])
    
    let ms = [0] + readLine()!.split(separator: " ").compactMap { Int($0) }
    
    var totalC = 0
    let cs = [0] + readLine()!.split(separator: " ").map {
        let n = Int($0)!
        totalC += n
        return n
    }
    
    var ans = totalC
    
    var dp: [[Int]] = .init(repeating: .init(repeating: 0, count: totalC + 1), count: n + 1)
    
    for i in 1...n {
        for j in 0...totalC {
            guard j >= cs[i] else {
                dp[i][j] = dp[i - 1][j]
                continue
            }
            dp[i][j] = max(
                dp[i - 1][j - cs[i]] + ms[i], dp[i - 1][j]
            )
            
            if dp[i][j] >= m { ans = min(ans, j) }
        }
    }
    print(ans)
    
}

// 1차원 DP
func _7579_1() {
    // Your solution here
    let nm = readLine()!.split(separator: " ").compactMap { Int($0) }
    let (n, m) = (nm[0], nm[1])
    
    let ms = [0] + readLine()!.split(separator: " ").compactMap { Int($0) }
    
    var totalC = 0
    let cs = [0] + readLine()!.split(separator: " ").map {
        let n = Int($0)!
        totalC += n
        return n
    }
    
    var ans = totalC
    
    var dp: [Int] = .init(repeating: 0, count: totalC + 1)
    for i in 1...n {
        for j in stride(from: totalC, through: cs[i], by: -1) {
            dp[j] = max(dp[j], dp[j - cs[i]] + ms[i])
            if dp[j] >= m { ans = min(ans, j) }
        }
    }
    print(ans)
}

