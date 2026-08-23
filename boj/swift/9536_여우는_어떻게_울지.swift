//
// 9536.swift
// Swift_Algorithm
//
// Created by zaehorang on 2026/2/6.
// https://acmicpc.net/problem/9536
//

import Foundation

func _9536() {
    // Your solution here
    let n = Int(readLine()!)!
    
    var ans = ""
    
    for _ in 0..<n {
        var test = readLine()!.split(separator: " ").map { String($0) }
        
        var sounds: [String] = []
        
        while true {
            let sound = readLine()!.split(separator: " ")
            guard sound[0] != "what" else { break }
            sounds.append(String(sound[2]))
        }
        
        for sound in sounds {
            test = test.filter { $0 != sound }
        }
        ans += "\(test.joined(separator: " "))\n"
    }
    print(ans)
}
