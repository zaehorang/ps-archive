//
// 2525.swift
// Swift_Algorithm
//
// Created by zaehorang on 2026/3/18.
// https://acmicpc.net/problem/2525
//

import Foundation

func _2525() {
    // Your solution here
    let ab = readLine()!.split(separator: " ").compactMap { Int($0) }
    let (a, b) = (ab[0], ab[1])
    
    let c = Int(readLine()!)!
    let na = c / 60
    let nb = c % 60
    
    let hour = ((a + na) + (b + nb) / 60) % 24
    let minute = (b + nb) % 60
    
    print("\(hour) \(minute)")
    
}

/// 전체 분으로 바꿨다가 다시 분해하는게 더 읽기 쉬운 최적해
func _2525_1() {
    let ab = readLine()!.split(separator: " ").map { Int($0)! }
    let a = ab[0]
    let b = ab[1]
    let c = Int(readLine()!)!

    let total = a * 60 + b + c
    let hour = (total / 60) % 24
    let minute = total % 60

    print(hour, minute)
}
