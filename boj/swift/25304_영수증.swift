//
// 25304.swift
// Swift_Algorithm
//
// Created by zaehorang on 2026/4/1.
// https://acmicpc.net/problem/25304
//

import Foundation

func _25304() {
    // Your solution here
    var tatal = Int(readLine()!)!
    
    for i in 0..<(Int(readLine()!)!) {
        let ab = readLine()!.split(separator: " ").compactMap { Int($0) }
        tatal -= (ab[0] * ab[1])
    }
    if tatal == 0 {
        print("Yes")
    } else {
        print("No")
    }
}
