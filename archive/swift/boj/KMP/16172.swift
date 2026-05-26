//
// 16172.swift
// Swift_Algorithm
//
// Created by zaehorang on 2026/1/21.
// https://acmicpc.net/problem/16172
//

import Foundation

func _16172() {
    // Your solution here
//    let s = readLine()!.map { $0 }.filter { $0.asciiValue! >= 65 }
    let s = Array(readLine()!).filter { $0.isLetter }
    let k = Array(readLine()!)
    
    func failure(_ arr: [Character]) -> [Int] {
        var failure: [Int] = .init(repeating: 0, count: arr.count)
        var j = 0
        
        for i in 1..<arr.count {
            while j > 0 && arr[i] != arr[j] { j = failure[j - 1] }
            if arr[i] == arr[j] {
                j += 1
                failure[i] = j
            }
        }
        
     return failure
    }
    
    let kf = failure(k)
    var j = 0
    
    for i in 0..<s.count {
        while j > 0 && s[i] != k[j] { j = kf[j - 1] }
        
        if s[i] == k[j] {
            j += 1
        }
        
        guard j != k.count else {
            print(1)
            return
        }
    }
    print(0)
}
