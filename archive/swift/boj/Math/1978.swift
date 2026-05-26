//
//  1978.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 7/10/25.
//  소수 찾기
//  https://www.acmicpc.net/problem/1978

import Foundation

// O(n)
func _1978_1() -> Int {
    let _ = Int(readLine() ?? "")!
    let arr = (readLine() ?? "")
        .split(separator: " ")
        .map { Int($0)! }
        .filter { num in
            var cnt = 0
            (1...num).forEach { n in
                num % n == 0 ? cnt += 1 : ()
            }
            return cnt == 2
        }

    return arr.count
}

// O(√n)
func _1978_2() -> Int {
    func isPrime(_ num: Int) -> Bool {
        guard num > 1 else { return false }
        
        for i in 2...num {
            // sqlt 메서드를 쓰지 않고 √n까지 계산하기 위함
            guard i * i <= num else { break }
            
            if num % i == 0 { return false }
        }
        
        return true
    }
    
    let _ = Int(readLine() ?? "")!
    let arr = (readLine() ?? "")
        .split(separator: " ")
        .map { Int($0)! }
        .filter { isPrime($0) }
    
    return arr.count
}
