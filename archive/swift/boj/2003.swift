//
// 2003.swift
// Swift_Algorithm
//
// Created by zaehorang on 2026/3/24.
// https://acmicpc.net/problem/2003
//

import Foundation

func _2003() {
    // Your solution here
    let nm = readLine()!.split(separator: " ").compactMap { Int($0) }
    let (n, m) = (nm[0], nm[1])
    
    let arr = readLine()!.split(separator: " ").compactMap { Int($0) }
    
    var start = 0
    var end = 0
    
    var total = 0
    var count = 0
    
    while start < n {
        if total >= m {
            total -= arr[start]
            start += 1
        } else if end == n {
            break
        } else {
            total += arr[end]
            end += 1
        }
        
        if total == m { count += 1 }
    }
    print(count)
}
