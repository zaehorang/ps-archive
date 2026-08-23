//
//  11726.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 3/21/25.
//  https://www.acmicpc.net/problem/11726
//  2xn 타일링

import Foundation

func _11726() -> Int {
    let n = Int(readLine()!)!
    
    var dp = [Int](repeating: 0, count: n + 1)
    
    if n == 1 { return 1 }
    
    dp[1] = 1
    dp[2] = 2
    
    var i = 3
    
    while i <= n {
        dp[i] = (dp[i-1] + dp[i-2])%10007
        i += 1
    }
    
    return dp[n]
}
