//
// 9996.swift
// Swift_Algorithm
//
// Created by zaehorang on 2026/2/3.
// https://acmicpc.net/problem/9996
//

import Foundation

func _9996() {
    // Your solution here
    let n = Int(readLine()!)!
    let ab = readLine()!.split(separator: "*")
//    let ab = readLine()!.components(separatedBy: "*")
    
    var ans = ""
    
    for _ in 0..<n {
        var str = readLine()!
        if str.hasSuffix(ab[1]) {
            let cut = str.index(str.endIndex, offsetBy: -ab[1].count)
            str.removeSubrange(cut..<str.endIndex)
            
            if str.hasPrefix(ab[0]) {
                ans += "DA\n"
            } else {
                ans += "NE\n"
            }
        } else {
            ans += "NE\n"
        }
    }
    print(ans)
}
