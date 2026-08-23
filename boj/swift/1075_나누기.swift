//
//  1075.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 12/16/25.
//  https://www.acmicpc.net/problem/1075

import Foundation

func _1075() {
    let N = Int(readLine()!)!
    let F = Int(readLine()!)!
    
    // 뒤에 두 자리 0으로 만들기
    let num = N / 100 * 100
    let remainder = num % F

    if remainder == 0 {
        print("00")
    } else {
        let ans = (F - remainder)
        ans < 10 ? print("0\(ans)") : print(ans)
    }
}

/// 포맷 문자열 (%02d) 방식으로 print
func _1075_short() {
    let N = Int(readLine()!)!
    let F = Int(readLine()!)!
    
    let num = N / 100 * 100
    let remainder = num % F
    
    if remainder == 0 {
        print("00")
    } else {
        let ans = (F - remainder)
        print(String(format: "%02d", ans))
    }
}
