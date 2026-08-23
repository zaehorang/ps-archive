//
//  1929.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 7/10/25.
//  소수 구하기
//  https://www.acmicpc.net/problem/1929

import Foundation

func _1929() -> [Int] {
    func primesArr(_ num: Int) -> [Int] {
        var primeState: [Bool] = .init(repeating: true, count: num + 1)
        primeState[1] = false
        
        for i in 2...num {
            guard i * i <= num else { break }
            guard primeState[i] else { continue }
            
            var j = i
            while j * i <= num {
                let index = j * i
                primeState[index] = false
                j += 1
            }
        }
        
        return (2...num).filter { primeState[$0] }
    }
    
    let NM = readLine()!
        .split(separator: " ")
        .map { Int($0)! }
    let (N, M) = (NM[0], NM[1])
    
    let arr = primesArr(M).filter { $0 >= N }
    
    return arr
}
