//
// 1969.swift
// Swift_Algorithm
//
// Created by zaehorang on 2026/2/5.
// https://acmicpc.net/problem/1969
//

import Foundation

func _1969() {
    // Your solution here
    let nm = readLine()!.split(separator: " ").compactMap { Int($0) }
    let (n, m) = (nm[0], nm[1])
    
    var dnas: [[Character]] = []
    for _ in 0..<n { dnas.append(Array(readLine()!)) }
    
    var ans = ""
    var hd = 0
    
    for i in 0..<m {
        var count: [(String, Int)] = [("A",0), ("C",0), ("G",0), ("T",0)]
        
        for j in 0..<n {
            switch dnas[j][i] {
            case "A": count[0].1 += 1
            case "C": count[1].1 += 1
            case "G": count[2].1 += 1
            case "T": count[3].1 += 1
            default: continue
            }
        }
        count.sort {
            if $0.1 == $1.1 { return $0.0 < $1.0 }
            return $0.1 > $1.1
        }
        
        ans += count[0].0
        for k in 1...3 { hd += count[k].1 }
    }
    
    print("\(ans)\n\(hd)")
}
