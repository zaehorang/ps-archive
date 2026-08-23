//
// 2444.swift
// Swift_Algorithm
//
// Created by zaehorang on 2026/3/19.
// https://acmicpc.net/problem/2444
//

import Foundation

func _2444() {
    // Your solution here
    let n = Int(readLine()!)!
    let empty = " "
    let star = "*"
    
    var stars: [String] = []
    
    for i in 1...n {
        let line = String(repeating: empty, count: n - i) +
        String(repeating: star, count: i)
        stars.append(line)
    }
    
    for i in 1..<n {
        stars[i] += String(repeating: star, count: i)
    }
    print(stars.joined(separator: "\n"))
    print(stars[0..<(n-1)].reversed().joined(separator: "\n"))
}

func _2444_1() {
    let n = Int(readLine()!)!

    for i in 1...n {
        let line = String(repeating: " ", count: n - i)
            + String(repeating: "*", count: 2 * i - 1)
        print(line)
    }

    if n > 1 {
        for i in stride(from: n - 1, through: 1, by: -1) {
            let line = String(repeating: " ", count: n - i)
                + String(repeating: "*", count: 2 * i - 1)
            print(line)
        }
    }
}
