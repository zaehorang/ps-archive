//
//  18870.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 5/11/25.
//  좌표 압축
//  https://www.acmicpc.net/problem/18870

import Foundation

func _18870() {
    var dict: [Int: Int] = [:]
    
    let _ = readLine()
    let arr = readLine()!
        .split(separator: " ")
        .map { Int(String($0))! }
    
    var idx = 0
    
    arr.sorted()
        .enumerated()
        .forEach {
            if dict[$1] == nil {
                dict[$1] = idx
                idx += 1
            }
        }
    
    arr.forEach {
        print(dict[$0]!, terminator: " ")
    }
    
}

// MARK: 이분탐색으로 다르게 풀어보기
func _18870_other() {
    let _ = readLine()
    let originalArr = readLine()!
        .split(separator: " ")
        .map { Int(String($0))! }
    
    let arr = originalArr.sorted()
    
    var before = arr.first!
    var newArr = [before]
    
    // 중복 제거
    arr.forEach {
        if $0 != before {
            newArr.append($0)
            before = $0
        }
    }
    
    // 이분 탐색
    originalArr.forEach {
        var start = 0
        var end = newArr.count - 1
        
        while start <= end {
            let mid = (start + end) / 2
            let midValue = newArr[mid]
            
            if midValue == $0 { // 찾았다!
                print(mid, terminator: " ")
                break
            } else { // 못찾았다!
                if midValue > $0 {
                    end = mid - 1
                } else {
                    start = mid + 1
                }
            }
        }
        
    }
}
