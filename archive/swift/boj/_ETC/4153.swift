//
//  4153.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 12/27/25.
//  https://www.acmicpc.net/problem/4153

import Foundation

func _4153() {
    while true {
        let lengths = readLine()!.split(separator: " ").map { Int($0)! }.sorted()
        
        guard lengths[0] != 0 else { return }
        
        func makeSquare(_ n: Int) -> Int { n * n }
        
        if makeSquare(lengths[2]) == makeSquare(lengths[0]) +  makeSquare(lengths[1]) {
            print("right")
        } else {
            print("wrong")
        }
    }
}
