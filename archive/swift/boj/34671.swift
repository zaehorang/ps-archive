//
// 34671.swift
// Swift_Algorithm
//
// Created by zaehorang on 2026/2/17.
// https://acmicpc.net/problem/34671
//

import Foundation

/*
시간초과
(주의) N이 큰 문제에서 인접행렬(2차 배열)은 N^2 메모리가 필요해 메모리 초과가 발생할 수 있음.
이 함수는 개념용(또는 N이 아주 작을 때만)으로만 참고.
*/
func _34671() {
    // Your solution here
    
    let nmq = readLine()!.split(separator: " ").compactMap { Int($0) }
    let n = nmq[0], m = nmq[1], q = nmq[2]
    
    var table: [[Int]] = .init(repeating: .init(repeating: -1, count: n + 1), count: n + 1)
    
    for _ in 0..<m {
        let abc = readLine()!.split(separator: " ").compactMap { Int($0) }
        let a = abc[0], b = abc[1], c = abc[2]
        
        table[a][b] = c
        table[b][a] = c
    }
    
    var ans = ""
    for _ in 0..<q {
        let se = readLine()!.split(separator: " ").compactMap { Int($0) }
        let s = se[0], e = se[1]
        
        ans += "\(table[s][e])\n"
    }
    print(ans)
}


/// 결국 스캐너 시간 문제 (입력만 빠르게 바꿔도 통과하는 케이스)
func _34671_2() {
    // Your solution here
    final class FastScanner {
        private var data: [UInt8] = Array(FileHandle.standardInput.readDataToEndOfFile()) + [0]
        private var idx: Int = 0
        
        @inline(__always) private func skipSpaces() {
            while data[idx] == 10 || data[idx] == 13 || data[idx] == 32 || data[idx] == 9 { idx += 1 }
        }
        
        @inline(__always) func readInt() -> Int {
            skipSpaces()
            var sign = 1
            if data[idx] == 45 { sign = -1; idx += 1 }
            var num = 0
            while data[idx] >= 48 {
                num = num * 10 + Int(data[idx] - 48)
                idx += 1
            }
            return num * sign
        }
    }
    
    
    let scanner = FastScanner()
    let _ = scanner.readInt() // n (not needed for this approach)
    let m = scanner.readInt()
    let q = scanner.readInt()
    
    var table: [String: Int] = [:]
    
    for _ in 0..<m {
        let a = scanner.readInt()
        let b = scanner.readInt()
        let c = scanner.readInt()
        
        let minC = min(table["\(a) \(b)", default: Int.max], c)
        
        table["\(a) \(b)"] = minC
        table["\(b) \(a)"] = minC
    }
    
    var ans = ""
    for _ in 0..<q {
        let s = scanner.readInt()
        let e = scanner.readInt()
        ans += "\(table["\(s) \(e)", default: -1])\n"
    }
    print(ans)
}


/// Bit 계산 + 바이트 출력으로 좀 더 최적화 with 🤖
func _34671_1() {
    final class FastScanner {
        private var data: [UInt8] = Array(FileHandle.standardInput.readDataToEndOfFile()) + [0]
        private var idx: Int = 0
        
        @inline(__always) private func skipSpaces() {
            while data[idx] == 10 || data[idx] == 13 || data[idx] == 32 || data[idx] == 9 { idx += 1 }
        }
        
        @inline(__always) func readInt() -> Int {
            skipSpaces()
            var sign = 1
            if data[idx] == 45 { sign = -1; idx += 1 }
            var num = 0
            while data[idx] >= 48 {
                num = num * 10 + Int(data[idx] - 48)
                idx += 1
            }
            return num * sign
        }
    }
    
    @inline(__always) func makeKey(_ a: Int, _ b: Int) -> Int64 {
        // (a, b)를 1개의 Int64 키로 패킹
        //  - 상위 32비트: a
        //  - 하위 32비트: b
        // b를 UInt32로 한 번 제한해서(하위 32비트만 사용) 부호 확장(sign extension) 위험을 제거 (해당 문제는 1이상이라 없어도 되긴 함)
        return (Int64(a) << 32) | Int64(UInt32(b))
    }
    
    @inline(__always) func appendInt(_ x: Int, to out: inout [UInt8]) {
        // 목적: String("\(x)")를 만들지 않고, 정수 x를 ASCII 바이트로 직접 변환해 out([UInt8])에 추가한다.
        // 이유: 문자열 보간/누적(+=)은 할당/복사가 잦아지고 유니코드 처리 비용도 커서, 대량 출력에서 느려지기 쉽다.

        // 0은 아래 while(num > 0) 루프가 한 번도 돌지 않으므로 예외 처리
        if x == 0 {
            out.append(48) // ASCII '0'
            return
        }

        var num = x
        
        // 음수면 먼저 부호를 출력하고, 이후 절댓값을 digit로 분해한다.
        if num < 0 {
            out.append(45) // ASCII '-'
            num = -num
        }

        // num을 10으로 나눈 나머지(0~9)를 이용해 1의 자리부터 뽑으면 역순으로 나오므로,
        // 임시 배열에 거꾸로 쌓아두고 마지막에 reversed()로 정순 출력한다.
        var digits: [UInt8] = []
        digits.reserveCapacity(12)
        while num > 0 {
            let d = num % 10              // 마지막 자리 숫자 (0~9)
            digits.append(UInt8(d) + 48)  // ASCII '0'(48)을 더해 문자 바이트로 변환
            num /= 10                      // 마지막 자리 제거
        }
        
        // digits는 ['3','2','1']처럼 역순이므로 뒤집어서 out에 붙인다.
        for ch in digits.reversed() {
            out.append(ch)
        }
    }
    
    let scanner = FastScanner()
    let _ = scanner.readInt() // n (not needed for this approach)
    let m = scanner.readInt()
    let q = scanner.readInt()
    
    var table: [Int64: Int] = [:]
    table.reserveCapacity(m * 2)
    
    for _ in 0..<m {
        let a = scanner.readInt()
        let b = scanner.readInt()
        let c = scanner.readInt()
        
        let k1 = makeKey(a, b)
        if let prev = table[k1] {
            if c < prev {
                table[k1] = c
                table[makeKey(b, a)] = c
            }
        } else {
            table[k1] = c
            table[makeKey(b, a)] = c
        }
    }
    
    var out: [UInt8] = []
    out.reserveCapacity(q * 12)
    
    for _ in 0..<q {
        let s = scanner.readInt()
        let e = scanner.readInt()
        let v = table[makeKey(s, e)] ?? -1
        appendInt(v, to: &out)
        out.append(10) // \n
    }
    
    FileHandle.standardOutput.write(Data(out))
}
