//
//  FileIO.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 3/31/25.
//

import Foundation

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
    
    /// 공백/개행으로 구분된 토큰을 읽어 String으로 반환
    @inline(__always) func readString() -> String {
        var now = read()
        
        while now == 10 || now == 32 { now = read() } // 공백과 줄바꿈 무시
        
        let beginIndex = index - 1
        
        while now != 10, now != 32, now != 0 { now = read() }
        
        return String(bytes: Array(buffer[beginIndex..<(index - 1)]), encoding: .ascii)!
    }
    
    /// 공백/개행으로 구분된 토큰을 읽되, 문자열을 만들지 않고 바이트 값을 누적한 Int를 반환
    @inline(__always) func readStringSum() -> Int {
        var sum = 0
        var now = read()
        
        while now == 10 || now == 32 { now = read() } // 공백과 줄바꿈 무시
        
        while now != 10, now != 32, now != 0 {
            sum += Int(now)
            now = read()
        }
        
        return sum
    }
}
