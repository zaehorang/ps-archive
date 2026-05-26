//
// 15652.swift
// Swift_Algorithm
//
// Created by zaehorang on 2026/4/15.
// https://acmicpc.net/problem/15652
//

import Foundation

func _15652() {
    // Your solution here
    let nm = readLine()!.split(separator: " ").compactMap { Int($0) }
    let (n, m) = (nm[0], nm[1])
    
    let arr = Array(1...n)
    var ans = ""
    
    
    func recursion(_ current: [Int], _ count: Int, _ index: Int) {
        guard count < m else {
            ans += current.map { String($0) }.joined(separator: " ") + "\n"
            return
        }
        
        for i in index..<arr.count {
            recursion(current + [arr[i]], count + 1, i)
        }
    }
    
    recursion([], 0, 0)
    print(ans)
}

func _15652_1() {
    // Your solution here
    let nm = readLine()!.split(separator: " ").compactMap { Int($0) }
    let (n, m) = (nm[0], nm[1])
    
    let arr = Array(1...n)
    var ans = ""
    
    var current: [Int] = []
    
    func recursion(_ index: Int) {
        guard current.count < m else {
            ans += current.map { String($0) }.joined(separator: " ") + "\n"
            return
        }
        
        for i in index..<arr.count {
            current.append(arr[i])
            recursion(i)
            current.removeLast()
        }
    }
    
    recursion(0)
    print(ans)
}
