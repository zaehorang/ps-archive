//
// 16934.swift
// Swift_Algorithm
//
// Created by zaehorang on 2026/1/30.
// https://acmicpc.net/problem/16934
//

import Foundation

func _16934() {
    // Your solution here
    let n = Int(readLine()!)!
    
    let max = 100000 * 10 + 10
    var nxt: [[Int]] = .init(repeating: .init(repeating: -1, count: 26), count: max)
    var check: [Int] = .init(repeating: 0, count: max)
    
    let root = 1
    var unused = 2
    
    var ans = ""
    
    func c2i(_ char: Character) -> Int { Int(char.asciiValue! - Character("a").asciiValue!) }
    
    for _ in 0..<n {
        var nickname = ""
        var cur = root
        
        var isEnded = false
        
        for char in readLine()! {
            let cIdx = c2i(char)
            
            if nxt[cur][cIdx] == -1 {
                nxt[cur][cIdx] = unused
                unused += 1
                
                if !isEnded {
                    nickname += String(char)
                    isEnded = true
                }
            }
            
            if !isEnded { nickname += String(char) }
            cur = nxt[cur][cIdx]
        }
        
        check[cur] += 1
        if !isEnded && check[cur] != 1 { nickname += String(check[cur]) }
        
        ans += "\(nickname)\n"
    }
    print(ans)
}
