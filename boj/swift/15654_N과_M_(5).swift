//
// 15654.swift
// Swift_Algorithm
//
// Created by zaehorang on 2026/3/8.
// https://acmicpc.net/problem/15654
//

import Foundation

func _15654() {
    // Your solution here
    let nm = readLine()!.split(separator: " ").compactMap { Int($0) }
    let (n, m) = (nm[0], nm[1])
    
    let arr = readLine()!.split(separator: " ").compactMap { Int($0) }.sorted()
    
    // Backtracking
    
    var isVisted: [Bool] = .init(repeating: false, count: n)
    
    var ans = ""
    
    func recursion(_ count: Int, _ str: String) {
        guard count < m else {
            ans += "\(str)\n"
            return
        }
        
        for i in 0..<n {
            guard !isVisted[i] else { continue }
            isVisted[i] = true
            
            recursion(count + 1, str + "\(arr[i]) ")
            isVisted[i] = false
            
        }
    }
    
    recursion(0, "")
    
    print(ans)
}

func _15654_1() {
    // Your solution here
    let nm = readLine()!.split(separator: " ").compactMap { Int($0) }
    let (n, m) = (nm[0], nm[1])
    
    let arr = readLine()!.split(separator: " ").compactMap { Int($0) }.sorted()
    var isVisted: [Bool] = .init(repeating: false, count: n)
    
    var ans = ""
    
    func recursion(_ nums: [Int]) {
        guard nums.count < m else {
            let str = nums.map { String($0) }.joined(separator: " ")
            ans += "\(str)\n"
            return
        }
        
        for i in 0..<n {
            guard !isVisted[i] else { continue }
            
            isVisted[i] = true
            
            recursion(nums + [arr[i]])
            
            isVisted[i] = false
            
        }
    }
    
    recursion([])
    
    print(ans)
}
