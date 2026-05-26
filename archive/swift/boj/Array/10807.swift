//
//  10807.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 5/5/25.
//  개수 세기
//  https://www.acmicpc.net/problem/10807

import Foundation

func _10807() {
    let _ = Int(readLine()!)!
    let arr = readLine()!.split(separator: " ")
    let v = Int(readLine()!)!
    
    var ans = 0
    
    arr.forEach {
        if Int(String($0))! == v {
            ans += 1
        }
    }
    print(ans)
}
