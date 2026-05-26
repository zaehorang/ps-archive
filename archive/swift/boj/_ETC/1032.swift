//
//  1032.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 12/14/25.
//  https://www.acmicpc.net/problem/1032

import Foundation

func _1032() {
    let N = Int(readLine()!)!
    
    var table: [[Character]] = []
    
    for _ in 0..<N {
        let str = readLine()!
        table.append(Array(str))
    }
    
    var ans = ""
    
    for i in 0..<table.first!.count {
        var before: Character = " "
        var isSame = true
        
        for arr in table {
            if before == " " {
                before = arr[i]
                continue
            }
            
            if arr[i] != before {
                ans += "?"
                isSame = false
                break
            }
        }
        if isSame { ans += String(before) }
    }
    print(ans)
}

/// allSatisfy 메서드 사용으로 더 짧게 가능
func _1032_other() {
    let N = Int(readLine()!)!
    let table = (0..<N).map { _ in Array(readLine()!) }
    
    var ans = ""
    
    for i in 0..<table[0].count {
        let char = table[0][i]
        let isSame = table.allSatisfy { $0[i] == char }
        
        if !isSame {
            ans += "?"
        } else {
            ans += String(char)
        }
    }
    print(ans)
}
