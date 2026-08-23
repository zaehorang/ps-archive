//
// 5622.swift
// Swift_Algorithm
//
// Created by zaehorang on 2026/3/22.
// https://acmicpc.net/problem/5622
//

import Foundation

func _5622() {
    let word = Array(readLine()!)
    var ans = 0

    for char in word {
        switch char {
        case "A", "B", "C":
            ans += 3
        case "D", "E", "F":
            ans += 4
        case "G", "H", "I":
            ans += 5
        case "J", "K", "L":
            ans += 6
        case "M", "N", "O":
            ans += 7
        case "P", "Q", "R", "S":
            ans += 8
        case "T", "U", "V":
            ans += 9
        case "W", "X", "Y", "Z":
            ans += 10
        default:
            break
        }
    }

    print(ans)
}

func _5622_1() {
    let word = Array(readLine()!)
    let firstA = Int(Character("A").asciiValue!)
    var ans = 0

    for char in word {
        let diff = Int(char.asciiValue!) - firstA
        var adjusted = diff

        if diff >= 18 { adjusted -= 1 } // S부터 보정
        if diff == 25 { adjusted -= 1 } // Z 한 번 더 보정

        ans += adjusted / 3 + 3
    }

    print(ans)
}
