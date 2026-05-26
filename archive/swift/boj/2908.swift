//
// 2908.swift
// Swift_Algorithm
//
// Created by zaehorang on 2026/4/14.
// https://acmicpc.net/problem/2908
//

import Foundation

func _2908() {
    // Your solution here
    let ab = readLine()!.split(separator: " ").compactMap {
        Int(String($0.reversed()))
    }
    print(ab.max()!)
}
