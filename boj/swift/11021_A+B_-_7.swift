//
// 11021.swift
// Swift_Algorithm
//
// Created by zaehorang on 2026/3/29.
// https://acmicpc.net/problem/11021
//

import Foundation

func _11021() {
    // Your solution here
    let n = Int(readLine()!)!
    
    for i in 1...n {
        print("Case #\(i): \(readLine()!.split(separator: " ").compactMap { Int($0) }.reduce(0, +))")
    }
}

