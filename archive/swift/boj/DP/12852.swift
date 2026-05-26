//
//  12852.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 3/24/25.
//

import Foundation

func _12852() {
    let n = Int(readLine()!)!
    
    var dp = [[Int]](repeating: [0, 0], count: n + 10)
    
    dp[1] = [0, 1]
    dp[2] = [1, 1]
    dp[3] = [1, 1]
    
    var index = 4
    
    while index <= n {
        dp[index][0] = dp[index - 1][0] + 1
        dp[index][1] = index - 1
        
        if index % 2 == 0 {
            if dp[index][0] > dp[index / 2][0] + 1 {
                dp[index][0] = dp[index / 2][0] + 1
                dp[index][1] = index / 2
            }
        }
        
        if index % 3 == 0 {
            if dp[index][0] > dp[index / 3][0] + 1 {
                dp[index][0] = dp[index / 3][0] + 1
                dp[index][1] = index / 3
            }
        }
        index += 1
    }
    
    print(dp[n][0])
    
    // 아래 코드보다 저 깔끔하게 쓰는 방식
    var current = n
    
    while true {
        print(current, terminator: " ")
        
        if current == 1 { break }
        
        current = dp[current][1]
    }
    
//    var ans = [n]
//    
//    while pIndex > 1 {
//        let next = dp[pIndex][1]
//        ans.append(next)
//        
//        pIndex = next
//    }
//    
//    print(dp[n][0])
//    
//    ans.forEach {
//        print($0, terminator: " ")
//    }
}
