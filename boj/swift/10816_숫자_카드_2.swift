//
//  10816.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 4/7/25.
//  숫자 카드 2
//  https://www.acmicpc.net/problem/10816

import Foundation

// dictionary를 이용해서 O(n)에 풀기
func _10816() {
    let _ = Int(readLine()!)!
    
    var nDic = [Int: Int]()
    
    readLine()!.split(separator: " ").forEach {
        let key = Int($0)!
        nDic[key] = nDic[key, default: 0] + 1
    }
    
    let _ = Int(readLine()!)!
    let ans = readLine()!.split(separator: " ")
        .map {
            String(nDic[Int($0)!, default: 0])
        }
        .joined(separator: " ")
        
    print(ans)
}

// Binary Search를 이용해서 풀기
func _10816_2() {
    let _ = Int(readLine()!)!
    let nArr = readLine()!
        .split(separator: " ")
        .map { Int($0)! }
        .sorted()
    
    let _ = Int(readLine()!)!
    let mArr = readLine()!.split(separator: " ").map { Int($0)! }
    
    var ans = [String]()
    
    for i in mArr {
        let upperBoundIndex = upperBoundIndex(i, arr: nArr)
        let lowerBoundIndex = lowerBoundIndex(i, arr: nArr)

        ans.append(String(upperBoundIndex - lowerBoundIndex))
    }
    
    print(ans.joined(separator: " "))
}


