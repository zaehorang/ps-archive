//
//  2475.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 12/23/25.
//  https://www.acmicpc.net/problem/2475

import Foundation

func _2475() {
    let nums = readLine()!.split(separator: " ").map { Int($0)! }
    
    print(
        nums.reduce(0) { $0 + ($1 * $1) } % 10
    )
}
