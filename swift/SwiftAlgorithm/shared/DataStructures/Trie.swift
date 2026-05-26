//
//  Trie.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 1/28/26.
//


struct Trie {
    let root = 1
    var unused = 2
    
    // 상황에 따라 다름
    let max = 10000 * 500 + 5
    var check: [Bool]
    var nxt: [[Int]]
    
    init() {
        check = .init(repeating: false, count: max)
        nxt = .init(repeating: .init(repeating: -1, count :26), count: max)
    }
    
    func c2i(_ char: Character) -> Int {
        let a: Character = "a"
        return Int(char.asciiValue! - a.asciiValue!)
    }
    
    mutating func insert(_ str: String) {
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
        return check[cur]
    }
    
    mutating func erase(_ str: String) {
        var cur = root
        for char in str {
            let cIdx = c2i(char)
            if nxt[cur][cIdx] == -1 { return }
            cur = nxt[cur][cIdx]
        }
        check[cur] = false
    }
 }