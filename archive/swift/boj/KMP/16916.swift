//
// 16916.swift
// Swift_Algorithm
//
// Created by zaehorang on 2026/1/21.
// https://acmicpc.net/problem/16916
//

import Foundation

func _16916() {
    // Your solution here
    let s = readLine()!.map { $0 }
    let p = readLine()!.map { $0 }
    
    func failure(_ arr: [Character]) -> [Int] {
        var j = 0
        var failure: [Int] = .init(repeating: 0, count: p.count)

        for i in 1..<p.count {
            while j > 0 && p[i] != p[j] { j = failure[j - 1] }
            if p[j] == p[i] {
                j += 1
                failure[i] += j
            }
            
        }
        return failure
    }
    
    let pf = failure(p)
    var j = 0
    
    for i in 0..<s.count {
        while j > 0 && s[i] != p[j] { j = pf[j - 1] }
        
        if s[i] == p[j] { j += 1 }
        
        guard j != p.count else {
            print(1)
            return
        }
    }
    print(0)
}

// 시간초과
func _16916_1() {
    // Your solution here
    let s = readLine()!
    let p = readLine()!
    
    if s.contains(p) {
        print(1)
    } else {
        print(0)
    }
}
