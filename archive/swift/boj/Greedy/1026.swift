//
//  1026.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 3/31/25.
//  보물
//  https://www.acmicpc.net/problem/1026

import Foundation

func _1026() {
    _ = Int(readLine()!)!
    
    let a = readLine()!.split(separator: " ")
        .map { Int($0)! }
        .sorted(by: >)
    let b = readLine()!.split(separator: " ")
        .map { Int($0)! }
        .sorted(by: <)
    
    var ans = 0
    
    a.enumerated().forEach { (i, v) in
        ans += v * b[i]
    }
    
    print(ans)
}
