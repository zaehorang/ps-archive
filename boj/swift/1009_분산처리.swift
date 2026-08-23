//
//  1009.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 12/12/25.
//

import Foundation

func _1009() {
    let T = Int(readLine()!)!
    
    for _ in 0..<T {
        let ab = readLine()!.split(separator: " ").map { Int($0)! }
        
        let (a, b) = (ab[0], ab[1])
        
        var ans = 1
        
        let remaider = a % 10
        
        for _ in 0..<b {
            ans *= remaider
            ans %= 10
        }
        
        if ans == 0 {
            print(10)
        } else {
            print(ans)
        }
    }
}

// 일의 자리만 생각
func _1009_1() {
    let T = Int(readLine()!)!
    
    for _ in 0..<T {
        let ab = readLine()!.split(separator: " ").map { Int($0)! }
        
        let (a, b) = (ab[0], ab[1])
        
        var ans = 1
        
        for _ in 0..<b {
            ans *= a
            
            if ans > 10 { ans %= 10 }
            if ans == 0 { break }
        }
        
        if ans > 0 { print(ans) } else { print(10) }
    }
}

// 일의 자리만 생각 + 나머지 반복
func _1009_2() {
    let T = Int(readLine()!)!
    
    for _ in 0..<T {
        let ab = readLine()!.split(separator: " ").map { Int($0)! }
        
        let (a, b) = (ab[0], ab[1])
        var current = a % 10
        var pattern = [current]
        
        /// 일
        while true {
            current *= a
            current %= 10
            if current == pattern.first {
                break
            } else {
                pattern.append(current)
            }
        }
        
        let count = pattern.count
        var i = b % count - 1
        
        if i < 0 { i = count - 1 }
        
        pattern[i] == 0 ? print(10) : print(pattern[i])
        
    }
}
