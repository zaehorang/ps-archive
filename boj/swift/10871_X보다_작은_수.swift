//
// 10871.swift
// Swift_Algorithm
//
// Created by zaehorang on 2026/1/18.
// https://acmicpc.net/problem/10871
//

import Foundation

func _10871() {
    // Your solution here
    let nx = readLine()!.split(separator: " ").compactMap { Int($0) }
    
    print(
        readLine()!.split(separator: " ").compactMap { Int($0) }.filter { nx[1] > $0 }.map { String($0) }.joined(separator: " ")
    )
}
