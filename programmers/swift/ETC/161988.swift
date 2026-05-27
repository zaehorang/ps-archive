//
//  161988.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 3/15/25.
//

import Foundation

// MARK: - 시간초과 풀이 (백트래킹을 이용한 풀이)
func solution_161988(_ sequence:[Int]) -> Int {
    var ans = 0
    
    func recursion(idx: Int, value: Int, start: Bool, prevPlus: Bool) {
        // 배열의 범위를 벗어나면 recursion 종료
        guard idx < sequence.count else {
            ans = max(ans, value)
            return
        }
        
        if start {
            if prevPlus {
                recursion(idx: idx + 1, value: value + sequence[idx] * -1 , start: start, prevPlus: false)
                
                
            } else {
                recursion(idx: idx + 1, value: value + sequence[idx] * 1 , start: start, prevPlus: true)
            }
            
            ans = max(ans, value)
            
        } else {
            recursion(idx: idx + 1, value: sequence[idx] * 1 , start: true, prevPlus: true)
            recursion(idx: idx + 1, value: sequence[idx] * -1 , start: true, prevPlus: false)
            recursion(idx: idx + 1, value: 0, start: false, prevPlus: true)
        }
        
    }
    
    recursion(idx: 0, value: 0, start: false, prevPlus: true)
    
    return ans
}


func solution2_161988(_ sequence:[Int]) -> Int {
    let purse1 = sequence.enumerated()
        .map { $0.element * ($0.offset % 2 == 0 ? 1 : -1) }
    
    let purse2 = sequence.enumerated()
        .map { $0.element * ($0.offset % 2 == 0 ? -1 : 1) }
    
    print(purse1)
    print(purse2)
    
    var sum1 = purse1
    var sum2 = purse2
    
    for i in 1..<sum1.count {
        sum1[i] = purse1[i] + sum1[i - 1]
        sum2[i] = purse2[i] + sum2[i - 1]
    }
    
    print(sum1)
    print(sum2)
    
    let a = sum1.max()! - min(sum1.min()!, 0)
    let b = sum2.max()! - min(sum2.min()!, 0)
    
    return max(a, b)
}

// 🐯 첫 원소부터 연속 수열이 될 수 있음을 고려해야 한다.
//2번 : [-5] => 5
//7, 16, 19, 20번 : [6, -7, 16, 3, -4] => 29
