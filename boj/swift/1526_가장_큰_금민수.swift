//
// 1526.swift
// Swift_Algorithm
//
// Created by zaehorang on 2026/3/17.
// https://acmicpc.net/problem/1526
//

import Foundation

func _1526() {
    // Your solution here
    let ns = readLine()!
    let count = ns.count
    let n = Int(ns)!
    
    let dn: [Int] = [4, 7]
    var arr: [Int] = []
    
    func calculate(_ n: Int, _ current: Int, _ num: Int) {
        guard n > current else {
            arr.append(num)
            return
        }
        
        for i in dn {
            let new = num + i * Int(pow(10.0, Double(current)))
             calculate(n, current + 1, new)
        }
    }
    
    calculate(count, 0, 0)
    calculate(count - 1, 0, 0)
    arr.sort()
    
    var ans = 0
    for i in 0..<arr.count {
        guard arr[i] <= n else { break }
        ans = arr[i]
    }
    print(ans)
}

func _1526_1() {
    let n = Int(readLine()!)!
    var ans = 0
    
    func dfs(_ current: Int) {
        guard current <= n else { return }
        ans = max(ans, current)
        
        dfs(current * 10 + 4)
        dfs(current * 10 + 7)
    }
    dfs(4)
    dfs(7)
    print(ans)
}
