//
//  18258.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 1/1/26.
//  https://www.acmicpc.net/problem/18258

import Foundation

/*
 Swift로 알고리즘 풀 때 시간 줄이기
 - 문자열 비교 오래 걸림 -> 명령어를 UTF-8로 인코딩된 바이트의 합으로 비교
 - 결과물
 한 번에 출력하기
 */

func _18258() {
    final class FileIO {
        private let buffer: [UInt8]
        private var index: Int = 0
        
        init(fileHandle: FileHandle = FileHandle.standardInput) {
            buffer = Array(try! fileHandle.readToEnd()!) + [UInt8(0)]
        }
        
        @inline(__always) private func read() -> UInt8 {
            defer { index += 1 }
            return buffer[index]
        }
        
        @inline(__always) func readInt() -> Int {
            var sum = 0
            var now = read()
            var isPositive = true
            
            while now == 10 || now == 32 { now = read() }
            if now == 45 { isPositive.toggle(); now = read() }
            
            while now >= 48, now <= 57 {
                sum = sum * 10 + Int(now - 48)
                now = read()
            }
            
            return sum * (isPositive ? 1 : -1)
        }
        
        @inline(__always) func readString() -> String {
            var now = read()
            
            while now == 10 || now == 32 { now = read() }
            
            let beginIndex = index - 1
            
            while now != 10, now != 32, now != 0 { now = read() }
            
            return String(bytes: Array(buffer[beginIndex..<(index - 1)]), encoding: .ascii)!
        }
        
        @inline(__always) func readStringSum() -> Int {
            var sum = 0
            var now = read()
            
            while now == 10 || now == 32 { now = read() }
            
            while now != 10, now != 32, now != 0 {
                sum += Int(now)
                now = read()
            }
            
            return sum
        }
    }
    
    struct Queue {
         var arr = [Int]()
         var head = 0
        
        var size: Int { arr.count - head }
        
        var isEmpty: Int { size == 0 ? 1 : 0 }
        var front: Int { size == 0 ? -1 : arr[head] }
        var back: Int { size == 0 ? -1 : arr.last! }
        
        mutating func push(_ elem: Int) {
            arr.append(elem)
        }
        
        mutating func pop() -> Int {
            guard size != 0 else { return -1 }
            let elem = arr[head]
            head += 1
            
            return elem
        }
    }
    
    let IO = FileIO()
    
    let N = IO.readInt()
    var q = Queue()
    
    var ans = ""
    
    for _ in 0..<N {
        let command = IO.readStringSum()
        
        if command == 448 {
            q.push(IO.readInt())
        } else if command == 335 {
            ans += "\(q.pop())\n"
        } else if command == 443 {
            ans += "\(q.size)\n"
        } else if command == 559 {
            ans += "\(q.isEmpty)\n"
        } else if command == 553 {
            ans += "\(q.front)\n"
        } else {
            ans += "\(q.back)\n"
        }
    }
    print(ans)
}
