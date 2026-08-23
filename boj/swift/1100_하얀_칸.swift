//
//  1100.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 12/20/25.
//  https://www.acmicpc.net/problem/1100

import Foundation

func _1100() {
    var ans = 0
    
    for i in 1...8 {
        let arr = Array(readLine()!)
        var isWhite = i % 2 == 1 ? true : false
        
        for status in arr {
            if status == "F" && isWhite {
                ans += 1
            }
            isWhite.toggle()
        }
    }
    print(ans)
}
