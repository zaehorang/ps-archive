//
//  10950.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 12/30/25.
//  https://www.acmicpc.net/problem/10950

import Foundation

func _10950() {
    let n = Int(readLine()!)!
    
    for _ in 0..<n {
        print(
            readLine()!
                .split(separator: " ")
                .compactMap { Int($0) }
                .reduce(0, +)
        )
    }
}
