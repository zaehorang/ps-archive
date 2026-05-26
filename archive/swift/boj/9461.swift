//
// 9461.swift
// Swift_Algorithm
//
// Created by zaehorang on 2026/4/7.
// https://acmicpc.net/problem/9461
//

import Foundation

func _9461() {
    // Your solution here
    let n = Int(readLine()!)!
    var dp = [1, 1, 1, 2, 2]
    
    var cases = [Int]()
    var maxCase = 0
    
    for _ in 0..<n {
        let num = Int(readLine()!)!
        
        cases.append(num)
        maxCase = max(maxCase, num)
    }
    
    var ans = ""
    
    if maxCase < 5 {
        cases.forEach { ans += "\(dp[$0 - 1])\n" }
    } else {
        for i in 5...maxCase { dp.append(dp[i - 1] + dp[i - 5]) }
        cases.forEach { ans += "\(dp[$0 - 1])\n" }
    }
    
    print(ans)
}
