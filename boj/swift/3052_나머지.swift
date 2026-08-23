//
// 3052.swift
// Swift_Algorithm
//
// Created by zaehorang on 2026/1/19.
// https://acmicpc.net/problem/3052
//

import Foundation

func _3052() {
    // Your solution here
    var ans: Set<Int> = []
    
    for _ in 0..<10 {
        ans.insert(Int(readLine()!)! % 42)
    }
    print(ans.count)
}
