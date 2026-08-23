//
//  8958.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 12/25/25.
//  https://www.acmicpc.net/problem/8958

import Foundation

func _8958() {
    let n = Int(readLine()!)!

    for _ in 0..<n {
        let test = readLine()!
        
        var ans = 0
        var score = 1
        
        for res in test {
            if res == "O" {
                ans += score
                score += 1
            } else {
                score = 1
            }
        }
        print(ans)
    }
}
