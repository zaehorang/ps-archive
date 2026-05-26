//
//  2750.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 7/19/24.
//  https://www.acmicpc.net/problem/2750
//  수 정렬하기

func _2750() {
    let n = Int(readLine()!)!
    var arr: [Int] = []
    
    for _ in 0..<n {
        arr.append(Int(readLine()!)!)
    }
    
    arr.sort()
    
    for n in arr {
        print(n)
    }
}
