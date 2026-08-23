//
// 1932.swift
// Swift_Algorithm
//
// Created by zaehorang on 2026/3/18.
// https://acmicpc.net/problem/1932
//

import Foundation


/// 시간초과
func _1932() {
    // Your solution here
    let n = Int(readLine()!)!
    var triangle = [0]
    
    for _ in 0..<n {
        let line = readLine()!.split(separator: " ").compactMap { Int($0) }
        triangle += line
    }
    
    var ans = 0
    
    func dfs( _ a: Int, _ index: Int, _ current: Int) {
        guard a < n else {
            ans = max(ans, current)
            return
        }
        
        let leftIdx = index + a
        let rightIdx = index + a + 1
        
        dfs(a + 1, leftIdx, current + triangle[leftIdx])
        dfs(a + 1, rightIdx, current + triangle[rightIdx])
    }
    
    dfs(1, 1, triangle[1])
    
    print(ans)
}

func _1932_1() {
    // Your solution here
    let n = Int(readLine()!)!
    var triangle: [[Int]] = [[]]
    
    for _ in 0..<n {
        let line = readLine()!.split(separator: " ").compactMap { Int($0) }
        triangle.append(line)
    }
    
    var dp: [[Int]] = triangle
    
    guard n > 1 else {
        print(triangle[1][0])
        return
    }
    
    for i in 2...n {
        for j in 0..<i {
            if j == 0 {
                dp[i][j] += dp[i-1][j]
                continue
            }
            
            if j == (i - 1) {
                dp[i][j] += dp[i - 1][j-1]
                continue
            }
            
            dp[i][j] += max(dp[i - 1][j - 1], dp[i - 1][j])
        }
    }
    print(dp[n].max()!)
}

/// 1차원 DP 배열로 변경
func _1932_2() {
    let n = Int(readLine()!)!
    var dp = Array(repeating: 0, count: n)

    for i in 0..<n {
        let line = readLine()!.split(separator: " ").map { Int($0)! }

        for j in stride(from: i, through: 0, by: -1) {
            if j == 0 {
                dp[j] = dp[j] + line[j]
            } else if j == i {
                dp[j] = dp[j - 1] + line[j]
            } else {
                dp[j] = max(dp[j - 1], dp[j]) + line[j]
            }
        }
    }

    print(dp.max()!)
}

