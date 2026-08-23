//
//  2675.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 12/24/25.
//  https://www.acmicpc.net/problem/2675

import Foundation

func _2675() {
    let T = Int(readLine()!)!
    
    for _ in 0..<T {
        let command = readLine()!.split(separator: " ")
        let (n, str) = (Int(command[0])!, String(command[1]))
        
        let string = str.map {
            String(repeating: $0, count: n)
        }.joined()
        print(string)
    }
}
