//
// 1110.swift
// Swift_Algorithm
//
// Created by zaehorang on 2026/3/15.
// https://acmicpc.net/problem/1110
//

import Foundation

func _1110() {
    // Your solution here
    let n = Int(readLine()!)!
    var value = n
    
    var ans = 0
    
    while true {
        ans += 1
        
        let first = value / 10
        let second = value % 10
        
        let newValue = 10 * second + (first + second) % 10
        
        if newValue == n {
            print(ans)
            return
        } else {
            value = newValue
        }
    }
}
