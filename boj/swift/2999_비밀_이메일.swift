//
// 2999.swift
// Swift_Algorithm
//
// Created by zaehorang on 2026/2/6.
// https://acmicpc.net/problem/2999
//

import Foundation

func _2999() {
    // Your solution here
    let str = [" "] + Array(readLine()!)
    let strCnt = str.count - 1
    var r = strCnt
    var c = 1
    
    for i in 1..<(strCnt/2) { // c
        if strCnt % i == 0 {
            let nr = strCnt / i
            if i > nr { break }
            c = i
            r = nr
        }
    }
    
    var ans = ""
    
    for col in 1...c {
        for row in 0..<r {
           let idx = col + row * c
            ans += String(str[idx])
        }
    }
    print(ans)
}
