//
// 1351.swift
// Swift_Algorithm
//
// Created by zaehorang on 2026/2/12.
// https://acmicpc.net/problem/1351
//

import Foundation

/*
 N이 크기 때문에 Bottom-up 방식으로 모든 값을 채울 수 없음
 
 0 ≤ N ≤ 1012
 2 ≤ P, Q ≤ 109
 */
func _1351() {
    // Your solution here
    let npq = readLine()!.split(separator: " ").compactMap { Int($0) }
    let n = npq[0], p = npq[1], q = npq[2]
    
    var dic: [Int: Int] = [0:1]
    
    func cal(_ i: Int) -> Int {
        if dic[i] != nil { return dic[i]! }
        
        dic[i, default: -1] = cal(i/p) + cal(i/q)
        
        return dic[i]!
    }
    
    print(cal(n))
}
