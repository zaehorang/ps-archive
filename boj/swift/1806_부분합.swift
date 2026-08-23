//
//  1806.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 7/8/25.
//  부분합
//  https://www.acmicpc.net/problem/1806

import Foundation

func _1806() -> Int {
    let ns = readLine()!.split(separator: " ").map { Int($0)! }
    let (n, s) = (ns[0], ns[1])
    
    let arr = readLine()!.split(separator: " ").map { Int($0)! }
    
    var en = 0
    
    var total = arr[0]
    var count = Int.max
    
    for st in 0..<n {
        
        while en < n && total < s {
            en += 1
            if en != n { total += arr[en] }
        }
        
        if en == n { break }
        
        count = min(count, en - st + 1)
        total -= arr[st]
    }
    if count == Int.max { return 0 }
    
    return count
}
