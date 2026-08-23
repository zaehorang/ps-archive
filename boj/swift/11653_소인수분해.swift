//
//  11653.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 7/28/25.
//  소인수분해
//  https://www.acmicpc.net/problem/11653

import Foundation

func _11653() {
    var N = Int(readLine()!)!
    var i = 2
    
    while i * i <= N {
        if N % i == 0 {
            print(i)
            
            N /= i
        } else {
            i += 1
        }
    }
    
    if N != 1 {
        print(N)
    }
}
