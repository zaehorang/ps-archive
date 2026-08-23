//
//  1644.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 7/10/25.
//  소수의 연속합
//  https://www.acmicpc.net/problem/1644

import Foundation

// 시간 초과
// -> 소수 판별 메서드를 O(n)에서 O(√n)로 변경하니까 풀림
func _1644() -> Int {
    // 소수 판별 메서드
    func checkPrime(_ n: Int) -> Bool {
        if n < 2 {
            return false
        }
        for i in 2..<Int(sqrt(Double(n)) + 1) {
            if n % i == 0 { return false }
        }
        return true
    }
    
    let N = Int(readLine()!)!
    
    guard N > 1 else { return 0 }
    
    let arr = (2...N).filter { checkPrime($0) }
    
    var en = 1
    var tot = arr[0]
    
    var ans = 0
    
    for st in 0..<arr.count {
        guard st < en else { break }
        
        while tot < N && en < arr.count {
            tot += arr[en]
            en += 1
        }
        
        if tot == N {
            ans += 1
        }
        
        tot -= arr[st]
    }
    
    return ans
}
