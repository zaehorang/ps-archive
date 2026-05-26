//
//  2920.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 1/2/26.
//  https://www.acmicpc.net/problem/2920

import Foundation

func _2920() {
    let arr = readLine()!.split(separator: " ").compactMap { Int($0) }
    
   var isAsc = false
    var isDes = false
    
    for i in 0..<8 {
        if arr[i] == i + 1 && !isDes {
            isAsc = true
        } else if arr[i] == 8 - i && !isAsc {
            isAsc = false
            isDes = true
        } else {
            print("mixed")
            return
        }
    }
    
    isAsc ? print("ascending") : print("descending")
}
