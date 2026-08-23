//
// 5597.swift
// Swift_Algorithm
//
// Created by zaehorang on 2026/3/23.
// https://acmicpc.net/problem/5597
//

import Foundation

func _5597() {
    // Your solution here
    var arr: [Bool] = .init(repeating: false, count: 31)
    for _ in 1...28 { arr[Int(readLine()!)!] = true }
    for i in 1...30 where !arr[i] { print(i) }
}
