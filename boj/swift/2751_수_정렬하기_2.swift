//
//  2751.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 7/22/24.
//  https://www.acmicpc.net/problem/2751
//  수 정렬하기 2

func _2751() {
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

