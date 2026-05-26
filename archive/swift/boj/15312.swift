//
// 15312.swift
// Swift_Algorithm
//
// Created by zaehorang on 2026/2/7.
// https://acmicpc.net/problem/15312
//

import Foundation

func _15312() {
    // Your solution here
    let strokeCounts: [Int] = [3, 2, 1, 2, 3, 3, 2, 3, 3, 2, 2, 1, 2, 2, 1, 2, 2, 2, 1, 2, 1, 1, 1, 2, 2, 1]
    let asciiA = Character("A").asciiValue!
    
    let a = readLine()!.map { Int($0.asciiValue! - asciiA) }
    let b = readLine()!.map { Int($0.asciiValue! - asciiA) }
    
    var first: [Int] = []
    first.reserveCapacity(a.count * 2)
    
    for i in 0..<a.count {
        first.append(strokeCounts[a[i]])
        first.append(strokeCounts[b[i]])
    }
    
//    while first.count > 2 {
//        var arr: [Int] = []
//        for i in 0..<first.count - 1 {
//            let val = (first[i] + first[i+1]) % 10
//            arr.append(val)
//        }
//        first = arr
//    }
    
    /// in-place로 메모리 줄이기 (할당 최소)
    while first.count > 2 {
        for i in 0..<(first.count - 1) {
            first[i] = (first[i] + first[i + 1]) % 10
        }
        first.removeLast()
    }

    print("\(first[0])\(first[1])")
}
