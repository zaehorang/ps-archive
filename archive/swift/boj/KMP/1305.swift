//
// 1305.swift
// Swift_Algorithm
//
// Created by zaehorang on 2026/1/26.
// https://acmicpc.net/problem/1305
//

/*
 failure[L-1]는 “문자열의 끝부분이 앞부분과 얼마나 겹치나(겹치는 최대 길이)”이고,
 L - failure[L-1]는 “그 겹침을 만들기 위해 필요한 최소 블록(광고판에 반복해서 붙일 최소 광고 길이)”이다.
 */

import Foundation

func _1305() {
    // Your solution here
    let _ = Int(readLine()!)!
    let arr = Array(readLine()!)
    
    var j = 0
    var last = 0
    
    var failure: [Int] = .init(repeating: 0, count: arr.count)
    
    for i in 1..<arr.count {
        while j > 0 && arr[i] != arr[j] { j = failure[j - 1]}
        if arr[i] == arr[j] {
            j += 1
            failure[i] = j
            
            if failure[i] == 0 { last = i }
        }
    }
    print(last + 1)
}
