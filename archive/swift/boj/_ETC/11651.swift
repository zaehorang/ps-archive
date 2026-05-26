//
//  11651.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 12/27/25.
//  https://www.acmicpc.net/problem/11651

import Foundation

func _11651() {
    let N = Int(readLine()!)!
    var coordinators: [[Int]] = []
    
    for _ in 0..<N {
        let coordinator = readLine()!.split(separator: " ").map { Int($0)! }
        coordinators.append(coordinator)
    }
    
    let ans = coordinators.sorted {
        if $0[1] != $1[1] {
            return $0[1] < $1[1]
        } else {
            return $0[0] < $1[0]
        }
    }.map { "\($0[0]) \($0[1])" }.joined(separator: "\n")
    
    print(ans)
}
