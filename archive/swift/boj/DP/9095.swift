//
//  9095.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 3/17/25.
//  https://www.acmicpc.net/problem/9095
//  1, 2, 3 더하기

import Foundation

func _9095() {
    let n = Int(readLine()!)!
    
    let arr = (0..<n).map { _ in Int(readLine()!)! }
    
    var table = [Int](repeating: 0, count: 15)
    
    // 1
    table[0] = 1
    // 2
    table[1] = 2
    // 3
    table[2] = 4
    
    
    for i in 3..<11 {
        table[i] = table[i - 1] + table[i - 2] + table[i - 3]
    }
        
    arr.forEach {
        print(table[$0 - 1])
    }
}
