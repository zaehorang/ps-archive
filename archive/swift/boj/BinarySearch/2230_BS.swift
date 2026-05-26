//
//  2230_BS.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 7/3/25.
//  수 고르기
//  https://www.acmicpc.net/status?user_id=zaehorang2&problem_id=2230&from_mine=1

import Foundation

func _2230_BS() -> Int {
    let nm = readLine()!.split(separator: " ").map { Int($0)! }
    let (n, m) = (nm[0], nm[1])
    
    var arr = [Int]()
    
    for _ in 0..<n {
        arr.append(Int(readLine()!)!)
    }
    
    arr.sort()
    var ansMin = Int.max
    
    for i in 0..<n {
        let idx = lowerBoundIndex(m + arr[i], arr: arr)
        guard idx < n else { break }
        
        ansMin = min(ansMin, arr[idx] - arr[i])
    }
    
    return ansMin
}
