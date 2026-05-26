//
// 2870.swift
// Swift_Algorithm
//
// Created by zaehorang on 2026/2/4.
// https://acmicpc.net/problem/2870
//

import Foundation

func _2870() {
    let n = Int(readLine()!)!

    let empty: Character = " "
    let A: UInt8 = 65

    func removeFrontZero(_ s: String) -> String {
        var i = 0
        for c in s {
            if c == "0" {
                i += 1
            } else {
                break
            }
        }
        let index = s.index(s.startIndex, offsetBy: i)
        return String(s[index..<s.endIndex])
    }
    
    var nums: [String] = []
    
    for _ in 0..<n {
        let line = readLine()!

        let nsArr: [Character] = Array(line).map { (ch: Character) -> Character in
            if let v = ch.asciiValue, v >= A { return empty }
            return ch
        }

        let nArr = String(nsArr).split(separator: " ")

        for sn in nArr {
            if let n = Int(sn) {
                nums.append(String(n))
            } else {
                nums.append(removeFrontZero(String(sn)))
            }
        }
    }
    
    nums.sort {
        if $0.count < $1.count {
            return true
        } else if $0.count == $1.count {
            return $0 < $1
        }
        return false
    }
    print(nums.joined(separator: "\n"))
}

func _2870_2() {
    let n = Int(readLine()!)!
    var nums: [String] = []
    nums.reserveCapacity(n * 2)
    
    func normalized(_ s: String) -> String {
        let trimmed = s.drop(while: { $0 == "0" })
        return trimmed.isEmpty ? "0" : String(trimmed)
    }

    for _ in 0..<n {
        let line = readLine()!
        var current = ""
        
        for ch in line {
            if ch.isNumber {
                current.append(ch)
            } else if !current.isEmpty {
                nums.append(normalized(current))
                current.removeAll(keepingCapacity: true)
            }
        }
        
        if !current.isEmpty { nums.append(normalized(current)) }
    }

    nums.sort {
        if $0.count != $1.count { return $0.count < $1.count }
        return $0 < $1
    }

    print(nums.joined(separator: "\n"))
}
