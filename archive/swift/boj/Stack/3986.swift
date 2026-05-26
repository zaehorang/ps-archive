//
//  main.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 4/20/24.
//  https://www.acmicpc.net/problem/3986

//MARK: -  input
var n = Int(readLine()!)!

//MARK: - solve
var ans = 0

//while n > 0 {

for _ in 0..<n {
    let str = readLine()!
    
    var s = [Character]()
    
    for a in str {
        
        if let last = s.last, last == a {
            s.removeLast()
        } else {
            s.append(a)
        }
        
    }
    
//    if s.isEmpty {
//        ans += 1
//    }
    
    // 😎
    if !s.isEmpty {
        n -= 1
    }
    
}

print(n)
