//
// 10815.swift
// Swift_Algorithm
//
// Created by zaehorang on 2026/3/14.
// https://acmicpc.net/problem/10815
//

import Foundation

func _10815() {
    // Your solution here
    var dict: [Int: [Bool]] = [:]
    
    let _ = Int(readLine()!)!
    readLine()!.split(separator: " ").forEach {
        let ns = Int(String($0))!
        if ns < 0 {
            dict[ns * -1, default: [false, false]][0] = true
        } else {
            dict[ns, default: [false, false]][1] = true
        }
        
    }
    let _ = Int(readLine()!)!
    let targets = readLine()!.split(separator: " ").compactMap { Int($0)! }
    
    var ans = ""
    
    for target in targets {
        if target < 0 {
            if dict[target * -1, default: [false, false]][0] {
                ans += "1 "
                continue
            }
        } else {
            if dict[target, default: [false, false]][1] {
                ans += "1 "
                continue
            }
        }
        ans += "0 "
    }
    print(ans)
}


func _10815_1() {
    let _ = Int(readLine()!)!
    let cards = Set(readLine()!.split(separator: " ").compactMap { Int($0) })

    let _ = Int(readLine()!)!
    let targets = readLine()!.split(separator: " ").compactMap { Int($0) }

    let result = targets.map { cards.contains($0) ? "1" : "0" }
    print(result.joined(separator: " "))
}
