//
//  1463.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 3/17/25.
//  https://www.acmicpc.net/problem/1463
//  1로 만들기

import Foundation

func _1464() {
    let n = Int(readLine()!)!
    
    // 1번 인덱스부터 저장
    // n == 1인 경우는 계산 필요 없음
    var table = [Int](repeating: 0, count: 1000001)
    
    if n == 1 {
        print(table[1])
        return
    }
    
    for i in 2...n {
        // -1인 경우
        let a = 1 + table[i-1]
        var b = 0
        
        if i % 2 == 0 && i % 3 == 0 {
            b = 1 + min(table[i/2], table[i/3])
        } else if i % 2 == 0 {
            b = 1 + table[i/2]
        } else if i % 3 == 0 {
            b = 1 + table[i/3]
        } else {
            table[i] = a
            continue
        }
        table[i] = min(a, b)
    }
    print(table[n])
}

func _1464_optimize() -> Int {
    let n = Int(readLine()!)!
    
    var table = [Int](repeating: 0, count: 1000005)
    
    if n == 1 { return table[1] }
    
    for i in 2...n {
        table[i] = 1 + table[i-1]
        
        // 위에서 3개의 분기를 아래와 같이 두개로 나눌 수도 있다.
        // 두 상황을 함께 비교해야 하는 상황도 있기 때문에 조건문을 각각 따로 써야 한다.
        if i%2 == 0 {
            table[i] = min(table[i], 1 + table[i/2])
        }
        if i%3 == 0 {
            table[i] = min(table[i], 1 + table[i/3])
        }
    }
    
    return table[n]
}


