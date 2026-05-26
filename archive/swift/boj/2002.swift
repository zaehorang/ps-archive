//
// 2002.swift
// Swift_Algorithm
//
// Created by zaehorang on 2026/2/16.
// https://acmicpc.net/problem/2002
//

import Foundation

func _2002() {
    // Your solution here
    let n = Int(readLine()!)!
    
    var enter: [String] = []
    var head = 0
    
    var ans = 0
    var check: [String: Bool] = [:]
    
    for _ in 0..<n {
        enter.append(readLine()!)
    }
    for _ in 0..<n {
        let exit = readLine()!
        
        if enter[head] == exit {
            head += 1
            guard head < n else { break }
            
            while check[enter[head], default: false] {
                head += 1
                guard head < n else { break }
            }
            
        } else {
            check[exit] = true
            ans += 1
        }
    }
    print(ans)
}

// MARK: - _2002_1 (비교용) 추월당한 차 수 🤖 GPT 처음에 틀림 ㅋ 제출 전에 내가 반박
// "추월당한 차"(피해자) = 자신보다 늦게 들어온 차가 먼저 나간 적이 있는 차
// 퇴장 인덱스 배열 E를 왼쪽→오른쪽으로 보며 maxSeen(지금까지의 최대 인덱스)을 유지합니다.
// 현재 p < maxSeen 이면, 더 늦게 들어온 차(큰 인덱스)가 이미 먼저 나갔다는 뜻 → 나는 추월당함.
func _2002_1() {
    let n = Int(readLine()!)!

    // 들어온 순서: 차량번호 -> 인덱스
    var pos: [String: Int] = [:]
    pos.reserveCapacity(n)
    for i in 0..<n {
        pos[readLine()!] = i
    }

    var maxSeen = -1
    var ans = 0

    // 나간 순서를 왼쪽→오른쪽으로 보며 '추월당한 차' 판정
    for _ in 0..<n {
        let p = pos[readLine()!]!   // 들어온 순서 인덱스

        if p < maxSeen {
            ans += 1    // 추월당한 차(피해자)
        } else {
            maxSeen = p
        }
    }

    print(ans)
}

// MARK: - _2002_2 (정답) 추월한 차 수
// "추월한 차"(가해자) = 자신보다 먼저 들어온 차가 있는데 그 차보다 먼저 나간 차
// 퇴장 인덱스 배열 E를 오른쪽→왼쪽으로 보며 minRight(오른쪽 최소 인덱스)를 유지합니다.
// 현재 E[i] > minRight 이면, 오른쪽에 더 먼저 들어온 차(더 작은 인덱스)가 남아있다는 뜻 → 나는 추월함.
func _2002_2() {
    let n = Int(readLine()!)!

    // 들어온 순서: 차량번호 -> 인덱스
    var pos: [String: Int] = [:]
    pos.reserveCapacity(n)
    for i in 0..<n {
        pos[readLine()!] = i
    }

    // 나간 순서를 들어온 인덱스로 변환
    var E: [Int] = []
    E.reserveCapacity(n)
    for _ in 0..<n {
        E.append(pos[readLine()!]!)
    }

    // 오른쪽 최소값을 유지하며 '추월한 차' 판정
    var minRight = Int.max
    var ans = 0

    for i in (0..<n).reversed() {
        if E[i] > minRight { ans += 1 }
        minRight = min(minRight, E[i])
    }

    print(ans)
}
