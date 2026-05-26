//
// 10809.swift
// Swift_Algorithm
//
// Created by zaehorang on 2026/1/15.
// https://acmicpc.net/problem/10809
//

import Foundation

func _10809() {
    // Your solution here
    var dic: [Character: Int] = [:]
    var count = 0
    
    for (i, c) in "abcdefghijklmnopqrstuvwxyz".enumerated() {
        dic[c, default: 0] = i
        count += 1
    }
    
    var ans: [Int] = .init(repeating: -1, count: count)
    
    for (i, char) in readLine()!.enumerated() {
        guard ans[dic[char]!] == -1 else { continue }
        ans[dic[char]!] = i
    }
    
    var p = ""
    for i in ans { p += "\(i) " }
    print(p)
}

/*
 askii
 - A = 65
 - a = 97
 */
func _10809_1() {
    // Your solution here
    var ansArr: [Int] = .init(repeating: -1, count: 26)
    
    for (i, c) in readLine()!.enumerated() {
        let index = Int(c.asciiValue! % 97)
        guard ansArr[index] == -1 else { continue }
        ansArr[index] = i
    }
    var ans = ""
    
    for c in ansArr { ans += "\(c) "}
    print(ans)
}
