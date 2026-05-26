//
// 1065.swift
// Swift_Algorithm
//
// Created by zaehorang on 2026/3/20.
// https://acmicpc.net/problem/1065
//

import Foundation

func _1065() {
    // Your solution here
    let n = Int(readLine()!)!
    
    guard n >= 10 else {
        print(n)
        return
    }
    
    guard n < 1000 else {
        print(144)
        return
    }
    
    var ans = 9
    
    
    for i in 10...n {
        if i >= 10 && i < 100 {
            ans += 1
            continue
        }
        var num = i
        
        let one = num % 10
        num /= 10
        
        let ten = num % 10
        num /= 10

        let hund = num

        if (hund - ten) == (ten - one) { ans += 1 }
    }
    print(ans)
    
}


func _1065_1() {
    let n = Int(readLine()!)!

    if n < 100 {
        print(n)
        return
    }

    var count = 99

    for number in 100...min(n, 999) {
        let hundreds = number / 100
        let tens = (number / 10) % 10
        let ones = number % 10

        if hundreds - tens == tens - ones {
            count += 1
        }
    }

    print(count)
}
