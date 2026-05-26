//
// 14426.swift
// Swift_Algorithm
//
// Created by zaehorang on 2026/1/28.
// https://acmicpc.net/problem/14426
//

import Foundation

func _14426() {
    // Your solution here
    let nm = readLine()!.split(separator: " ").compactMap { Int($0) }
    let (n, m) = (nm[0], nm[1])
    
    let root = 1
    var unused = 2
    let max = 10_000 * 500 + 5
    
    var nxt: [[Int]] = .init(repeating: .init(repeating: -1, count: 26), count: max)
    var check: [Bool] = .init(repeating: false, count: max)
    
    func c2i(_ char: Character) -> Int {
        let a: Character = "a"
        return Int(char.asciiValue! - a.asciiValue!)
    }
    
     func insert(_ str: String) {
        var cur = root
        for char in str {
            let cIdx = c2i(char)
            if nxt[cur][cIdx] == -1 {
                nxt[cur][cIdx] = unused
                unused += 1
            }
            cur = nxt[cur][cIdx]
        }
         check[cur] = true
    }
    
    func find(_ str: String) -> Bool {
        var cur = root
        for char in str {
            let cIdx = c2i(char)
            if nxt[cur][cIdx] == -1 { return false }
            cur = nxt[cur][cIdx]
        }
         return true
    }
    
    for _ in 0..<n { insert(readLine()!) }
    
    var ans = 0
    for _ in 0..<m { ans += find(readLine()!) ? 1 : 0 }
    print(ans)
}

func _14426_1() {
    // Your solution here
    let nm = readLine()!.split(separator: " ").compactMap { Int($0) }
    let (n, m) = (nm[0], nm[1])
    
    var s = [String]()
    for i in 0..<n { s.append(readLine()!) }
    s.sort{$0 < $1}
    
    var ans = 0
    
    
    func lowerBound(_ target: String) -> Int {
        var l = 0
        var r = s.count
        while l < r {
            let mid = (l + r) / 2
            if s[mid] < target {
                l = mid + 1
            } else {
                r = mid
            }
        }
        return l
    }
    
    for _ in 0..<m {
        let str = readLine()!
        let idx = lowerBound(str)
        if idx < s.count, s[idx].hasPrefix(str) { ans += 1}
    }
    print(ans)
}
