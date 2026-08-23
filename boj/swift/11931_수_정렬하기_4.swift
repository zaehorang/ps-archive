//
//  11931.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 7/24/24.
//  https://www.acmicpc.net/problem/11931

func _11931() {
    let n = Int(readLine()!)!
    var arr: [Int] = []

    for _ in 0..<n {
        arr.append(Int(readLine()!)!)
    }
    arr.sort(by: >)
    for n in arr {
        print(n)
    }
}


