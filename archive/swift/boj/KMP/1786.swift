//
// 1786.swift
// Swift_Algorithm
//
// Created by zaehorang on 2026/1/22.
// https://acmicpc.net/problem/1786
//

import Foundation

/*
OOIOIOIOIIOII
IOI
 3 5 7 10
 */
func _1786() {
    // Your solution here
    
    let t = Array(readLine()!)
    let p = Array(readLine()!)
    
    func failure(_ str: [Character]) -> [Int] {
        var j = 0
        var failure: [Int] = .init(repeating: 0, count: str.count)
        
        for i in 1..<str.count {
            while j > 0 && str[i] != str[j] { j = failure[j - 1]}
            if str[i] == str[j] {
                j += 1
                failure[i] = j
            }
        }
        
        return failure
    }
    
    let pf = failure(p)
    
    var count = 0
    var idx = ""
    
    var j = 0
    
    for i in 0..<t.count {
        while j > 0 && t[i] != p[j] { j = pf[j - 1] }
        if t[i] == p[j] { j += 1 }
        
        if j == p.count {
            count += 1
            idx += "\(i + 2 - p.count) "
            
            j = pf[j - 1]
        }
    }
    
    print("\(count)\n\(idx)")
}
