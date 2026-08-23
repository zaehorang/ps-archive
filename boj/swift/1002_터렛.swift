//
// 1002.swift
// Swift_Algorithm
//
// Created by zaehorang on 2026/2/11.
// https://acmicpc.net/problem/1002
//

import Foundation

func _1002() {
    let n = Int(readLine()!)!
    var out = ""

    func calculate(
        x1: Int, y1: Int, r1: Int,
        x2: Int, y2: Int, r2: Int
    ) -> Int {
        if x1 == x2 && y1 == y2 && r1 == r2 { return -1 }

        let dx = x1 - x2
        let dy = y1 - y2
        let d2 = dx * dx + dy * dy

        let sum = r1 + r2
        let diff = abs(r1 - r2)
        let sum2 = sum * sum
        let diff2 = diff * diff

        if d2 > sum2 { return 0 } // 외부
        if d2 < diff2 { return 0 } // 내부
        if d2 == sum2 || d2 == diff2 { return 1 } // 내접/ 외접
        return 2 // 두 점에서 만남
    }
    
    for _ in 0..<n {
        let v = readLine()!.split(separator: " ").compactMap { Int($0) }
        let result = calculate(
            x1: v[0], y1: v[1], r1: v[2],
            x2: v[3], y2: v[4], r2: v[5]
        )
        out += "\(result)\n"
    }

    print(out)
}
