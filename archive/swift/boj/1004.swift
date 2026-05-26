//
// 1004.swift
// Swift_Algorithm
//
// Created by zaehorang on 2026/2/13.
// https://acmicpc.net/problem/1004
//

import Foundation

func _1004() {
    // Your solution here
    typealias Point = (Int, Int)
    typealias Circle = (Int, Int, Int) // x, y, r
    
    func isInCircle(_ a: Point, _ c: Circle) -> Bool {
        let diff = (a.0 - c.0) * (a.0 - c.0) + (a.1 - c.1) * (a.1 - c.1)
        if c.2 * c.2 > diff { return true}
        return false
    }
    
    let t = Int(readLine()!)!
    var ans = ""
    for _ in 0..<t {
        
        let xyxy = readLine()!.split(separator: " ").compactMap { Int($0) }
        let p1 = (xyxy[0], xyxy[1]), p2 = (xyxy[2], xyxy[3])
        
        let n = Int(readLine()!)!
        
        var cnt = 0
        
        for _ in 0..<n {
            let c = readLine()!.split(separator: " ").compactMap { Int($0) }
            let a = isInCircle(p1, (c[0], c[1], c[2]))
            let b = isInCircle(p2, (c[0], c[1], c[2]))
            
            if a && b { continue }
            if !a && !b { continue }
            cnt += 1
        }
        ans += "\(cnt)\n"
    }
    print(ans)
}

func _1004_() {
    typealias Point = (Int, Int)
    typealias Circle = (Int, Int, Int) // x, y, r

    @inline(__always)
    func isInCircle(_ p: Point, _ c: Circle) -> Bool {
        let dx = p.0 - c.0
        let dy = p.1 - c.1
        let dist2 = dx * dx + dy * dy
        let r2 = c.2 * c.2
        return dist2 < r2   // 경계는 '밖'으로 처리 (문제 의도에 맞게 <)
    }

    let t = Int(readLine()!)!
    var out: [String] = []
    out.reserveCapacity(t)

    for _ in 0..<t {
        let xyxy = readLine()!.split(separator: " ").compactMap { Int($0) }
        let p1: Point = (xyxy[0], xyxy[1])
        let p2: Point = (xyxy[2], xyxy[3])

        let n = Int(readLine()!)!
        var cnt = 0

        for _ in 0..<n {
            let c = readLine()!.split(separator: " ").compactMap { Int($0) }
            let circle: Circle = (c[0], c[1], c[2])
            if isInCircle(p1, circle) != isInCircle(p2, circle) {
                cnt += 1
            }
        }
        out.append(String(cnt))
    }

    print(out.joined(separator: "\n"))
}
