//
// 1541.swift
// Swift_Algorithm
//
// Created by zaehorang on 2026/2/25.
// https://acmicpc.net/problem/1541
//

import Foundation

func _1541() {
    // Your solution here
    let str = Array(readLine()!)
    var isPositive = true
    
    var total = 0
    var current = ""

    for char in str {
        if char == "+" || char == "-" {
            if isPositive {
                total += Int(current)!
            } else {
                total -= Int(current)!
            }
            
            if isPositive, char == "-" { isPositive = false}
            current = ""
        } else {
            current.append(char)
        }
    }
    
    if isPositive {
        total += Int(current)!
    } else {
        total -= Int(current)!
    }
    
    print(total)
}

func _1541_1() {
    // BOJ 1541 "잃어버린 괄호" 핵심:
    // 첫 '-' 이후에 나오는 값들은 전부 한 번에 묶어서 빼는 것이 최솟값.
    // 따라서 '-' 기준으로 나눈 뒤,
    //   1) 첫 덩어리는 '+'로 더해서 total에 더하고
    //   2) 나머지 덩어리들은 각 덩어리 내부를 '+'로 더한 값을 total에서 빼면 된다.

    let minusParts = readLine()!.split(separator: "-")

    func sumOfPlus(_ part: Substring) -> Int {
        part.split(separator: "+").reduce(0) { $0 + Int($1)! }
    }

    var total = sumOfPlus(minusParts[0])
    
    for part in minusParts.dropFirst() {
        total -= sumOfPlus(part)
    }

    print(total)
}
