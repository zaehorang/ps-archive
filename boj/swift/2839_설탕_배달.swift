//
// 2839.swift
// Swift_Algorithm
//
// Created by zaehorang on 2026/3/18.
// https://acmicpc.net/problem/2839
//

import Foundation

func _2839() {
    // Your solution here
    let n = Int(readLine()!)!
    let end = n / 5
    
    guard end > 0 else {
        if n % 3 == 0 {
            print(n / 3)
        } else {
            print(-1)
        }
        return
    }
    
    var ans = -1
    
    for i in 0...end {
        let remainder = n - 5 * i
        if remainder % 3 == 0 {
            ans = i + remainder / 3
            
        }
    }
    print(ans)
}


func _2839_1() {
    let n = Int(readLine()!)!
    var five = n / 5

    while five >= 0 {
        let remainder = n - five * 5
        if remainder % 3 == 0 {
            print(five + remainder / 3)
            return
        }
        five -= 1
    }

    print(-1)
}
