//
//  2439.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 12/23/25.
//  https://www.acmicpc.net/problem/2439

import Foundation

func _2439() {
    let n = Int(readLine()!)!
    (1...n).forEach {
        var star = ""
        
        star += String(repeating: " ", count: n - $0)
        star += String(repeating: "*", count: $0)
        
        print(star)
    }
}
