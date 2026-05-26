//
//  15688.swift
//  AlgorithmStudy
//
// Created by zaehorang on 2026/1/24.
// https://acmicpc.net/problem/15688
//

import Foundation

func _15688() {
    final class FileIO {
        private let buffer: [UInt8]
        private var index: Int = 0
        
        init(fileHandle: FileHandle = FileHandle.standardInput) {
            buffer = Array(try! fileHandle.readToEnd()!) + [UInt8(0)] // 인덱스 범위 넘어가는 것 방지
        }
        
        @inline(__always) private func read() -> UInt8 {
            defer { index += 1 }
            return buffer[index]
        }
        
        @inline(__always) func readInt() -> Int {
            var sum = 0
            var now = read()
            var isPositive = true
            
            while now == 10 || now == 32 { now = read() } // 공백과 줄바꿈 무시
            if now == 45 { isPositive.toggle(); now = read() } // 음수 처리
            
            while now >= 48, now <= 57 {
                sum = sum * 10 + Int(now - 48)
                now = read()
            }
            
            return sum * (isPositive ? 1 : -1)
        }
    }
    let io = FileIO()
    
    let n = io.readInt()
    var counting: [Int: Int] = [:]
    
    for _ in 0..<n {
        let num = io.readInt()
        counting[num, default: 0] += 1
    }
    
    var ans = ""
    
    for (k, v) in counting.sorted(by: { a, b in a.key < b.key }) {
        ans += String(repeating: "\(k)\n", count: v)
    }
    
    print(ans)
}
