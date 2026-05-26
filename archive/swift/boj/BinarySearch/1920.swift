//
//  1920.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 4/6/25.
//  수 찾기
//  https://www.acmicpc.net/problem/1920

import Foundation

func _1920() {
    let n = Int(readLine()!)!
    let arr1 = readLine()!
        .split(separator: " ")
        .map { Int($0)! }
        .sorted()  // O(nlog(n)
    
    let m = Int(readLine()!)!
    let arr2 = readLine()!.split(separator: " ").map { Int($0)! }
    
    var i = 0
    
    while i < m {
        let target = arr2[i]
        
        var st = 0
        var en = n - 1
        
        
        var isFind = false
        
        while st <= en {  // Binary Search: O(log(n))
            let mid = (st + en) / 2
            
            if arr1[mid] > target {
                en = mid - 1
            } else if arr1[mid] < target {
                st = mid + 1
            } else {
                isFind = true
                break
            }
        }
        
        isFind ? print(1) : print(0)
        i += 1
    }
}
