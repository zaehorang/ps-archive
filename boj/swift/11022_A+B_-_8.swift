//
// 11022.swift
// Swift_Algorithm
//
// Created by zaehorang on 2026/4/6.
// https://acmicpc.net/problem/11022
//

import Foundation

func _11022() {
    // Your solution here
    let n = Int(readLine()!)!
    
    for i in 1...n {
        let ab = readLine()!.split(separator: " ").compactMap { Int($0) }
        let (a, b) = (ab[0], ab[1])
        print("Case #\(i): \(a) + \(b) = \(a + b)")
    }
}

