//
//  11723.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 12/19/25.
//

import Foundation

/*
 Swift 코드 주의
 1. print 오래 걸림 -> 최종본 한 번에 프린팅
 2. ⭐️ Strign 비교 오래 걸림 -> String을 Int로 변환해서 매칭
 
 결국 1, 2번 만족하니까 다 가능
 */

func _11723() {
    final class FileIO {
        private let buffer:[UInt8]
        private var index: Int = 0
        
        init(fileHandle: FileHandle = FileHandle.standardInput) {
            
            buffer = Array(try! fileHandle.readToEnd()!)+[UInt8(0)] // 인덱스 범위 넘어가는 것 방지
        }
        
        @inline(__always) private func read() -> UInt8 {
            defer { index += 1 }
            
            return buffer[index]
        }
        
        @inline(__always) func readInt() -> Int {
            var sum = 0
            var now = read()
            var isPositive = true
            
            while now == 10
                    || now == 32 { now = read() } // 공백과 줄바꿈 무시
            if now == 45 { isPositive.toggle(); now = read() } // 음수 처리
            while now >= 48, now <= 57 {
                sum = sum * 10 + Int(now-48)
                now = read()
            }
            
            return sum * (isPositive ? 1:-1)
        }
        
        @inline(__always) func readString() -> String {
            var now = read()
            
            while now == 10
                    || now == 32 { now = read() } // 공백과 줄바꿈 무시
            let beginIndex = index-1
            
            while now != 10,
                  now != 32,
                  now != 0 { now = read() }
            
            return String(bytes: Array(buffer[beginIndex..<(index-1)]), encoding: .ascii)!
        }
        
        @inline(__always) func readStirngSum() -> Int {
                var byte = read()
                while byte == 10 || byte == 32 { byte = read() }
                var sum = Int(byte)
                while byte != 10 && byte != 32 && byte != 0 { byte = read(); sum += Int(byte) }
                return sum - Int(byte)
            }
    }
    
    let fileIO = FileIO()
    
    let M = fileIO.readInt()
    var set: Set<Int> = .init()
    
    let all: Set<Int> = {
        var inital: Set<Int> = .init()
        (1...20).forEach { inital.insert($0) }
        return inital
    }()
    let empty: Set<Int> = .init()
    
    var ans = ""
    
    func perform(_ command: Int) {
        if command == 313 {
            set = all
        } else if command == 559 { // empty
            set = empty
        } else {
            let n = fileIO.readInt()
            
            if command == 297 {
                set.insert(n)
            } else if command == 654 {
                set.remove(n)
            } else if command == 510 {
                ans += set.contains(n) ? "1\n" : "0\n"
            } else if command == 642 {
                
                if set.contains(n) {
                    set.remove(n)
                } else {
                    set.insert(n)
                }
            }
        }
        print(set)
    }
    
    for _ in 0..<M {
        perform(fileIO.readStirngSum())
    }
    print(ans)
}

// 배열 인덱스 풀이
func _11723_1() {
    final class FileIO {
        private let buffer:[UInt8]
        private var index: Int = 0
        
        init(fileHandle: FileHandle = FileHandle.standardInput) {
            
            buffer = Array(try! fileHandle.readToEnd()!)+[UInt8(0)] // 인덱스 범위 넘어가는 것 방지
        }
        
        @inline(__always) private func read() -> UInt8 {
            defer { index += 1 }
            
            return buffer[index]
        }
        
        @inline(__always) func readInt() -> Int {
            var sum = 0
            var now = read()
            var isPositive = true
            
            while now == 10
                    || now == 32 { now = read() } // 공백과 줄바꿈 무시
            if now == 45 { isPositive.toggle(); now = read() } // 음수 처리
            while now >= 48, now <= 57 {
                sum = sum * 10 + Int(now-48)
                now = read()
            }
            
            return sum * (isPositive ? 1:-1)
        }
        
        @inline(__always) func readString() -> String {
            var now = read()
            
            while now == 10
                    || now == 32 { now = read() } // 공백과 줄바꿈 무시
            let beginIndex = index-1
            
            while now != 10,
                  now != 32,
                  now != 0 { now = read() }
            
            return String(bytes: Array(buffer[beginIndex..<(index-1)]), encoding: .ascii)!
        }
        
        @inline(__always) func readByteSequenceWithoutSpaceAndLineFeed() -> [UInt8] {
            var now = read()
            
            while now == 10 || now == 32 { now = read() } // 공백과 줄바꿈 무시
            let beginIndex = index-1
            
            while now != 10,
                  now != 32,
                  now != 0 { now = read() }
            
            return Array(buffer[beginIndex..<(index-1)])
        }
        
        @inline(__always) func readStirngSum() -> Int {
                var byte = read()
                while byte == 10 || byte == 32 { byte = read() }
                var sum = Int(byte)
                while byte != 10 && byte != 32 && byte != 0 { byte = read(); sum += Int(byte) }
                return sum - Int(byte)
            }
    }
    
    let fileIO = FileIO()
    
    var arr: [Bool] = .init(repeating: false, count: 21)
    
    let all: [Bool] = .init(repeating: true, count: 21)
    let empty: [Bool] = .init(repeating: false, count: 21)
    
    let M = fileIO.readInt()
    
    var ans = ""
    
    func perform(_ command: Int) {
        if command == 313 {
            arr = all
        } else if command == 559 { // empty
            arr = empty
        } else {
            let n = fileIO.readInt()
            
            if command == 297 {
                arr[n] = true
            } else if command == 654 {
                arr[n] = false
            } else if command == 510 {
                ans += arr[n] ? "1\n" : "0\n"
            } else if command == 642 {
                arr[n] = arr[n] ? false : true
            }
        }
    }
    
    for _ in 0..<M {
        perform(fileIO.readStirngSum())
    }
    print(ans)
}


/// 비트 마스킹 풀이
func _11723_2() {
    final class FileIO {
        private let buffer:[UInt8]
        private var index: Int = 0
        
        init(fileHandle: FileHandle = FileHandle.standardInput) {
            
            buffer = Array(try! fileHandle.readToEnd()!)+[UInt8(0)] // 인덱스 범위 넘어가는 것 방지
        }
        
        @inline(__always) private func read() -> UInt8 {
            defer { index += 1 }
            
            return buffer[index]
        }
        
        @inline(__always) func readInt() -> Int {
            var sum = 0
            var now = read()
            var isPositive = true
            
            while now == 10
                    || now == 32 { now = read() } // 공백과 줄바꿈 무시
            if now == 45 { isPositive.toggle(); now = read() } // 음수 처리
            while now >= 48, now <= 57 {
                sum = sum * 10 + Int(now-48)
                now = read()
            }
            
            return sum * (isPositive ? 1:-1)
        }
        
        @inline(__always) func readString() -> String {
            var now = read()
            
            while now == 10
                    || now == 32 { now = read() } // 공백과 줄바꿈 무시
            let beginIndex = index-1
            
            while now != 10,
                  now != 32,
                  now != 0 { now = read() }
            
            return String(bytes: Array(buffer[beginIndex..<(index-1)]), encoding: .ascii)!
        }
        
        @inline(__always) func readStirngSum() -> Int {
                var byte = read()
                while byte == 10 || byte == 32 { byte = read() }
                var sum = Int(byte)
                while byte != 10 && byte != 32 && byte != 0 { byte = read(); sum += Int(byte) }
                return sum - Int(byte)
            }
    }
    
    let fileIO = FileIO()
    
    let M = fileIO.readInt()
    
    var state = 0
    var ans = ""
    
    func perform(_ command: Int) {
        if command == 313 { // all
            state = 0xFFFFF // 20bits
        } else if command == 559 { // empty
            state = 0
        } else {
            let n = fileIO.readInt()
            
            if command == 297 { // add
                state |= (1 << (n - 1))
            } else if command == 654 { // remove
                state &= (~(1 << (n - 1)))
            } else if command == 510 { // check
                ans += "\(((state >> (n - 1)) & 1))\n"
            } else if command == 642 { // toggle
                state ^= (1 << (n - 1))
            }
        }
    }
    
    for _ in 0..<M {
        perform(fileIO.readStirngSum())
    }
    print(ans)
}
