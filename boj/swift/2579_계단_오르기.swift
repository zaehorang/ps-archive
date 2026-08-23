//
//  2579.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 3/20/25.
//  https://www.acmicpc.net/problem/2579
//  계단 오르기

import Foundation

func _2579() -> Int {
    let n = Int(readLine()!)!
    var arr = [0]
    
    for _ in 0..<n {
        arr.append(Int(readLine()!)!)
    }
    
    if n <= 1 {
        return arr.last!
    }
    
    var dp: [[Int]] = .init(repeating: [0, 0, 0], count: n + 1)
    
    dp[1][1] = arr[1]
    dp[1][2] = 0
    
    dp[2][1] = arr[2]
    dp[2][2] = arr[1] + arr[2]
    
    var i = 3
    
    // for문을 쓰는 것보다 while을 쓰는게 이후에 index 범위 문제를 해결하는게 편한 듯!
    while i <= n {
        dp[i][1] = max(dp[i-2][2], dp[i-2][1]) + arr[i]
        
        dp[i][2] = dp[i-1][1] + arr[i]
        
        i += 1
    }
    
    return max(dp[n][1], dp[n][2])
}

func _2579_other() -> Int {
    let n = Int(readLine()!)!
    var arr = [0]
    var tot = 0
    
    for _ in 0..<n {
        let num = Int(readLine()!)!
        
        arr.append(num)
        tot += num
    }
    
    if n <= 2 {
        return tot
    }
    
    var dp = [Int](repeating: 0, count: n + 1)
    
    dp[1] = arr[1]
    dp[2] = arr[2]
    dp[3] = arr[3]
    
    var i = 4
    
    while i <= n {
        dp[i] = min(dp[i-2], dp[i-3]) + arr[i]
        
        i += 1
    }
    
    return tot - min(dp[n - 1], dp[n-2])
}
