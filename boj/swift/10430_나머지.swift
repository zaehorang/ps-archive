//
// 10430.swift
// Swift_Algorithm
//
// Created by zaehorang on 2026/3/7.
// https://acmicpc.net/problem/10430
//

import Foundation

func _10430() {
    // Your solution here
    let abc = readLine()!.split(separator: " ").compactMap { Int($0)! }
    let (A, B, C) = (abc[0], abc[1], abc[2])
    
    print((A + B) % C)
    print(((A % C) + (B % C)) % C)
    print((A * B) % C)
    print(((A % C) * (B % C)) % C)
}
