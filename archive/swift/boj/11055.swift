//
// 11055.swift
// Swift_Algorithm
//
// Created by zaehorang on 2026/2/26.
// https://acmicpc.net/problem/11055
//

import Foundation

func _11055() {
    // Your solution here
    let n = Int(readLine()!)!
    let nums = readLine()!.split(separator: " ").compactMap { Int($0) }
    
    var dp = nums
    
    for i in 1..<n {
        for j in 0..<i {
            if nums[i] > nums[j] {
                dp[i] = max(dp[i], nums[i] + dp[j])
            }
        }
    }
    print(dp.max()!)
}
