//
// 9012.swift
// Swift_Algorithm
//
// Created by zaehorang on 2026/3/17.
// https://acmicpc.net/problem/9012
//

import Foundation

func _9012() {
    // Your solution here
    let n = Int(readLine()!)!
    
    var ans = ""
    
    for _ in 0..<n {
        var stack: [Character] = []
        var isVPS = true
        
        for char in readLine()! {
            if char == "(" {
                stack.append(char)
            } else {
                guard !stack.isEmpty else {
                    isVPS = false
                    break
                }
                stack.removeLast()
            }
        }
        
        if stack.isEmpty && isVPS {
            ans += "YES\n"
        } else {
            ans += "NO\n"
        }
    }
    print(ans)
}

func _9012_1() {
    // Your solution here
    let n = Int(readLine()!)!
        var result: [String] = []

        for _ in 0..<n {
            var balance = 0
            var isVPS = true

            for char in readLine()! {
                if char == "(" {
                    balance += 1
                } else {
                    balance -= 1
                    if balance < 0 {
                        isVPS = false
                        break
                    }
                }
            }

            result.append(isVPS && balance == 0 ? "YES" : "NO")
        }

        print(result.joined(separator: "\n"))
}
