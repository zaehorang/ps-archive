//
//  11720.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 12/28/25.
//  https://www.acmicpc.net/problem/11720

import Foundation

func _11720() {
    let _ = readLine()
    let ans = readLine()!.reduce(0) {
        $0 + Int(String($1))!
    }
    print(ans)
}
