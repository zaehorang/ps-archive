//
//  10869.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 12/26/25.
//  https://www.acmicpc.net/problem/10869

import Foundation

func _10869() {
    let ab = readLine()!.split(separator: " ").map { Int($0)! }
    let (a, b) = (ab[0], ab[1])
    
    print("\(a + b)")
    print("\(a - b)")
    print("\(a * b)")
    print("\(a / b)")
    print("\(a % b)")
}
