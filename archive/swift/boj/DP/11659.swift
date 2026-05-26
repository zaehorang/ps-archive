//
//  11659.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 3/21/25.
//

import Foundation

func _11659(){
    let nm = readLine()!.split(separator: " ").map { Int($0)! }
    
    let (n, m) = (nm[0], nm[1])
    
    let nums = [0] + readLine()!.split(separator: " ").map { Int($0)! }
    
    var dp = [Int](repeating: 0, count: n + 1)

    var k = 1
    
    while k <= n {
        dp[k] = dp[k - 1] + nums[k]
        
        k += 1
    }
    
    var idx = 1
    
    while idx <= m {
        let ij = readLine()!.split(separator: " ").map { Int($0)! }
        
        let (i, j) = (ij[0], ij[1])
        
        print(dp[j] - dp[i-1])
        idx += 1
    }
}
