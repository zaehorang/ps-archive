//
// 1543.swift
// Swift_Algorithm
//
// Created by zaehorang on 2026/2/2.
// https://acmicpc.net/problem/1543
//

import Foundation

func _1543() {
    // Your solution here
    let str = Array(readLine()!)
    let target = Array(readLine()!)
    
    var pose = 0
    var ans = 0
    while pose <= str.count - target.count {
        if Array(str[pose..<(pose + target.count)]) == target {
            ans += 1
            pose += target.count
            continue
        }
        pose += 1
    }
    print(ans)
}
