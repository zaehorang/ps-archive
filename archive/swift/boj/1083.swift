//
// 1083.swift
// Swift_Algorithm
//
// Created by zaehorang on 2026/3/13.
// https://acmicpc.net/problem/1083
//

import Foundation

/*
 오답 풀이.

 왜 틀렸는가?
 - 이 문제는 "현재 위치에서 남은 교환 횟수 안으로 끌어올 수 있는 값들 중 최댓값"을 선택해야 한다.
 - 하지만 이 풀이는 버블 정렬처럼 앞에서부터 처음 발견한 `arr[i] < arr[i + 1]`만 바로 swap 한다.
 - 그래서 더 뒤에 있는 큰 값을 현재 자리까지 끌어와야 하는 경우를 놓친다.

 예시)
 arr = [1, 2, 3], S = 2
 - 현재 풀이는: [1, 2, 3] -> [2, 1, 3] -> [2, 3, 1]
 - 하지만 최적은 3을 맨 앞으로 끌어오는 것: [1, 2, 3] -> [1, 3, 2] -> [3, 1, 2]

 즉, "당장 앞의 큰 수와 한 번 교환"하는  greedy은 성립하지 않고,
 매 위치마다 도달 가능한 범위 내 최댓값을 골라 앞으로 당기는 방식으로 풀어야 한다.
 */
func _1083() {
    // Your solution here
    let n = Int(readLine()!)!
    var arr = readLine()!.split(separator: " ").compactMap { Int($0) }
    var count = Int(readLine()!)!
    
    var isEnded = false
    
    while count > 0 {
        for i in 0..<(n-1) {
            if arr[i] < arr[i+1] {
                arr.swapAt(i, i+1)
                count -= 1
                break
            }
            
            if i == (n-2) { isEnded = true }
        }
        
        guard !isEnded else { break }
    }
    print(arr.map { String($0) }.joined(separator: " "))
}


func _1083_1() {
    // Your solution here
    let n = Int(readLine()!)!
    var arr = readLine()!.split(separator: " ").compactMap { Int($0) }
    var count = Int(readLine()!)!
    
    var targetIdx = 0
    
    while count > 0 {
        guard targetIdx < n - 1 else { break }
        
        var maxIdx = targetIdx
        var max = arr[targetIdx]
        
        for i in targetIdx...min(n - 1, targetIdx + count) {
            if max < arr[i] {
                maxIdx = i
                max = arr[i]
            }
        }
        
        guard targetIdx != maxIdx else {
            targetIdx += 1
            continue
        }
        
        count -= (maxIdx - targetIdx)
        
        for i in stride(from: maxIdx, to: targetIdx, by: -1) {
            arr.swapAt(i, i - 1)
        }
        
        targetIdx += 1
    }
    print(arr.map { String($0) }.joined(separator: " "))
}
