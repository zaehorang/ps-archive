//
//  2558.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 12/30/25.
//

import Foundation

func _2258() {
    let a = Int(readLine()!)!
    let b = Int(readLine()!)!
    
    var copy = b
    for _ in 0..<3 {
        let n = copy % 10
        copy /= 10
        print(a * n)
    }
    print(a * b)
}
