//
//  2230.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 7/3/25.
//  수 고르기
//  https://www.acmicpc.net/problem/2230


import Foundation

func _2230() -> Int {
    let nm = readLine()!.split(separator: " ").map { Int($0)! }
    let (n, m) = (nm[0], nm[1])
    
    var arr = [Int]()
    
    for _ in 0..<n {
        arr.append(Int(readLine()!)!)
    }
    
    arr.sort()
    
    var (st, en) = (0, 0)
    var minAns = Int.max
    
    while true {
        guard en < n && st < n else { break }
        let val = arr[en] - arr[st]
        
        if val < m {
            en += 1
        } else { // 정답이 될 수 있는 조건
            minAns = min(val, minAns)
            st += 1
        }
    }
    
    return minAns
}

func _2230_2() -> Int {
    let nm = readLine()!.split(separator: " ").map { Int($0)! }
    let (n, m) = (nm[0], nm[1])
    
    var arr = [Int]()
    
    for _ in 0..<n {
        arr.append(Int(readLine()!)!)
    }
    
    arr.sort()
    
    var en = 0
    var minAns = Int.max
 
    for st in 0..<n {
        while en < n && arr[en] - arr[st] < m {
            en += 1
        }
        guard en < n else { break }
        minAns = min(arr[en] - arr[st], minAns)
    }
    return minAns
}
