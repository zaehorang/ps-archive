//
//  2217.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 3/30/25.
//  로프
//  https://www.acmicpc.net/problem/2217

import Foundation

func _2217() {
    let n = Int(readLine()!)!
    
    let ropes = (1...n)
        .map { _ in Int(readLine()!)! }
        .sorted()
    
    var ans = 0
    
    var i = 0
    
    while i < n {
        ans = max(ans, (n - i) * ropes[i])
        
        i += 1
    }
    
    print(ans)
}
