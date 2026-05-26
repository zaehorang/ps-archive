//
//  1149.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 3/20/25.
//  https://www.acmicpc.net/source/25952495
//  RGB 거리

import Foundation

// 그리디 방식
// 잘못된 풀이법: 한 번 선택한 이후의 선택이 전역적으로 유리하다는 보장이 없다.
func _1149() -> Int {
    let n = Int(readLine()!)!
    var table = [[Int]]()
    table.append([])
    
    for _ in 0..<n {
        let arr = readLine()!.split(separator: " ").map { Int($0)! }
        table.append(arr)
    }
    
    var dp1 = [[Int]](repeating: [0, 0, 0], count: n + 1)
    dp1[1][0] = table[1][0]
    
    var dp2 = [[Int]](repeating: [0, 0, 0], count: n + 1)
    dp2[1][1] = table[1][1]
    
    var dp3 = [[Int]](repeating: [0, 0, 0], count: n + 1)
    dp3[1][2] = table[1][2]
    
    func makeDP(dp: [[Int]]) -> [[Int]] {
        var dp = dp
        var i = 2
        
        while i <= n {
            if dp[i-1][0] > 0 { // 이전 집에서 빨강
                if table[i][1] >= table[i][2] {
                    dp[i][2] = dp[i-1][0] + table[i][2]
                } else {
                    dp[i][1] = dp[i-1][0] + table[i][1]
                    
                }
                
            } else if dp[i-1][1] > 0 { // 초록
                if table[i][0] >= table[i][2] {
                    dp[i][2] = dp[i-1][1] + table[i][2]
                } else {
                    dp[i][0] = dp[i-1][1] + table[i][0]
                }
            } else { // 파랑
                if table[i][0] >= table[i][1] {
                    dp[i][1] = dp[i-1][2] + table[i][1]
                } else {
                    dp[i][0] = dp[i-1][2] + table[i][0]
                }
            }
            i += 1
        }
        return dp
    }
    
    dp1 = makeDP(dp: dp1)
    dp2 = makeDP(dp: dp2)
    dp3 = makeDP(dp: dp3)
    
    print(dp1)
    print(dp2)
    print(dp3)
    
    let a = dp1[n].max()!
    let b = dp2[n].max()!
    let c = dp3[n].max()!
    
    return min(a, b, c)
}

// dp 방식 풀이
func _1149_other() -> Int {
    let n = Int(readLine()!)!
    var cost = [[Int]]()
    cost.append([])
    
    for _ in 0..<n {
        let arr = readLine()!.split(separator: " ").map { Int($0)! }
        cost.append(arr)
    }
    
    var dp = [[Int]](repeating: [0, 0, 0], count: n + 1)
    dp[1][0] = cost[1][0]
    dp[1][1] = cost[1][1]
    dp[1][2] = cost[1][2]
    
    var i = 2
    
    while i <= n {
        dp[i][0] = min(dp[i-1][1], dp[i-1][2]) + cost[i][0]
        dp[i][1] = min(dp[i-1][0], dp[i-1][2]) + cost[i][1]
        dp[i][2] = min(dp[i-1][1], dp[i-1][0]) + cost[i][2]
        
        i += 1
    }
    
    return dp[n].min()!
}
