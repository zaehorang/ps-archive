//
// 5052.swift
// Swift_Algorithm
//
// Created by zaehorang on 2026/1/29.
// https://acmicpc.net/problem/5052
//

import Foundation

func _5052() {
    // Your solution here
    let t = Int(readLine()!)!
    
    let max = 10000 * 10 + 5
    func c2i(_ char: Character) -> Int { Int(char.asciiValue! - Character("0").asciiValue!) }
    
    let top = 1
    
    func check(_ n: Int) -> String {
        var unused = 2
        
        var next: [[Int]] = .init(repeating: .init(repeating: -1, count: 10), count: max)
        var check: [Bool] = .init(repeating: false, count: max)
 
        var callNums = [[Character]]()
        for _ in 0..<n { callNums.append(Array(readLine()!)) }
        callNums.sort { $0.count < $1.count }
        
        for callNum in callNums {
            var cur = top
            
            for char in callNum {
                let cIdx = c2i(char)
                if next[cur][cIdx] == -1 {
                    next[cur][cIdx] = unused
                    unused += 1
                } else if check[next[cur][cIdx]] {
                    return "NO\n"
                }
                cur = next[cur][cIdx]
            }
            check[cur] = true
        }
        
        return "YES\n"
    }
    
    var ans = ""
    
    for _ in 0..<t {
        let n = Int(readLine()!)!
        ans += check(n)
    }
    print(ans)
}

/*
 - 아이디어
 전화번호들을 사전순(lexicographical) 정렬하면,
 어떤 번호 a가 다른 번호 b의 prefix라면 정렬 결과에서 a와 b는 반드시 이웃하게 붙어 나옴
 */
func _5052_prefix() {
    let t = Int(readLine()!)!
    var ans = ""

    for _ in 0..<t {
        let n = Int(readLine()!)!
        var numbers: [String] = []
        numbers.reserveCapacity(n)

        for _ in 0..<n { numbers.append(readLine()!) }

        numbers.sort()

        var ok = true
        for i in 0..<(n - 1) {
            if numbers[i + 1].hasPrefix(numbers[i]) {
                ok = false
                break
            }
        }

        ans += ok ? "YES\n" : "NO\n"
    }

    print(ans)
}
