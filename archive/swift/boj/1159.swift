//
// 1159.swift
// Swift_Algorithm
//
// Created by zaehorang on 2026/3/27.
// https://acmicpc.net/problem/1159
//

import Foundation

func _1159() {
    // Your solution here
    var counts: [Character: Int] = [:]
    let n = Int(readLine()!)!
    
    for _ in 0..<n {
        let line = readLine()!
        counts[line.first!, default: 0] += 1
    }
    
    var ans = ""
    counts.forEach { $0.value >= 5 ? ans.append($0.key) : () }
    if ans == "" {
        print("PREDAJA")
    } else {
        print(String(ans.sorted()))
    }
}
