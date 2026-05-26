//
// 1003.swift
// Swift_Algorithm
//
// Created by zaehorang on 2026/2/12.
// https://acmicpc.net/problem/1003
//

import Foundation

func _1003() {
    // Your solution here
    let n = Int(readLine()!)!
    
    var max = 0
    var test: [Int] = []
    for _ in 0..<n {
        let a = Int(readLine()!)!
        test.append(a)
        
        if max < a { max = a }
    }
    
    var d: [(Int, Int)] = .init(repeating: (0, 0), count: 41)
    d[0] = (1, 0)
    d[1] = (0, 1)
    
    if max >= 2 {
        for i in 2...max {
            d[i] = (d[i-1].0 + d[i-2].0, d[i-1].1 + d[i-2].1)
        }
    }
    
    var ans = ""
    
    for i in test { ans += "\(d[i].0) \(d[i].1)\n" }
    
    print(ans)
}


func _1003_1() {
    // Your solution here
    let n = Int(readLine()!)!
    
    var max = 0
    var test: [Int] = []
    for _ in 0..<n {
        let a = Int(readLine()!)!
        test.append(a)
        
        if max < a { max = a }
    }
    
    var d: [(Int, Int)] = .init(repeating: (0, 0), count: 41)
    d[0] = (1, 0)
    d[1] = (0, 1)
    
    if max >= 2 {
        for i in 2...max {
            d[i] = (d[i-1].0 + d[i-2].0, d[i-1].1 + d[i-2].1)
        }
    }
    
    var out: [String] = []
    out.reserveCapacity(n)
    
    for i in test {  out.append("\(d[i].0) \(d[i].1)") }
    
    print(out.joined(separator: "\n"))
}
