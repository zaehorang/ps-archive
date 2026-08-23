//
//  10818.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 12/26/25.
//  https://www.acmicpc.net/problem/10818

import Foundation

func _10818() {
    let _ = readLine()
    
    var maxNum = Int.min
    var minNum = Int.max
    
    readLine()!.split(separator: " ").forEach {
        let n = Int(String($0))!
        
        maxNum = max(maxNum, n)
        minNum = min(minNum, n)
    }
    
    print("\(minNum) \(maxNum)")
}
