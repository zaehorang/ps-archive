//
//  2447.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 6/11/24.
//  https://www.acmicpc.net/problem/2447
//  별 찍기 - 10

func _2447() {
    let n = Int(readLine()!)!
    
    var ans: [String] = .init(repeating: "", count: n)
    recursion_2447(x: 0, y: 0, n: n)
    
    ans.forEach { print($0) }
    
    func recursion_2447(x: Int, y: Int, n: Int) {
        let len = n / 3
        
        // base condition
        if len == 1 {
            ans[x] += "***"
            ans[x + 1] += "* *"
            ans[x + 2] += "***"
            return
        }
        
        recursion_2447(x: x, y: y, n: len)
        recursion_2447(x: x, y: y + len, n: len)
        recursion_2447(x: x, y: y + 2 * len, n: len)
        
        recursion_2447(x: x + len, y: y, n: len)
        addEmpty(x: x + len, n: len)
        recursion_2447(x: x + len, y: y + 2 * len, n: len)
        
        recursion_2447(x: x + 2 * len, y: y, n: len)
        recursion_2447(x: x + 2 * len, y: y + len, n: len)
        recursion_2447(x: x + 2 * len, y: y + 2 * len, n: len)
    }
    
    func addEmpty(x: Int, n: Int) {
        for i in x..<(x+n) {
            ans[i] += String(repeating: " ", count: n)
        }
    }
    
}


//MARK: - solve 2
// 으렵다 으려워 🥲
// 참고: https://dev-mandos.tistory.com/154
func _2447_1() {
    let n = Int(readLine()!)!
    
    func recursion_2447_1(n: Int, pattern: [String]) {
        if n == 1 {
            pattern.forEach { print($0) }
            return
        }
        
        let first = pattern.map { $0 + $0 + $0 }
        let empty = pattern.map { $0 + String(repeating: " ", count: $0.count) + $0 }
        
        recursion_2447_1(n: n / 3, pattern: first + empty + first)
    }
    
    recursion_2447_1(n: n, pattern: ["*"])
}

