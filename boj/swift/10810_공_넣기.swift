//
// 10810.swift
// Swift_Algorithm
//
// Created by zaehorang on 2026/3/19.
// https://acmicpc.net/problem/10810
//

import Foundation

func _10810() {
    // Your solution here
    let nm = readLine()!.split(separator: " ").compactMap { Int($0) }
    let (n, m) = (nm[0], nm[1])
    
    var basket: [Int] = .init(repeating: 0, count: n + 1)
    
    for _ in 0..<m {
        let ijk = readLine()!.split(separator: " ").compactMap { Int($0) }
        let (i, j, k) = (ijk[0], ijk[1], ijk[2])
        
        for idx in i...j {
            basket[idx] = k
        }
    }
    
    print(basket[1...n].map { String($0) }.joined(separator: " ") )
    
}
