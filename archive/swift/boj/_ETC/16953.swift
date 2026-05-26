//
//  16953.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 12/28/25.
//  https://www.acmicpc.net/problem/16953

import Foundation

func _16953() {
    let ab = readLine()!.split(separator: " ").compactMap { Int($0) }
    let (a, b) = (ab[0], ab[1])
    
    var ans = Int.max

    func recursion(_ n: Int, count: Int) {
        guard n < b else {
            if n == b { ans = min(ans, count) }
            return
        }
        
        recursion(n * 2, count: count + 1)
        recursion(n * 10 + 1, count: count + 1)
    }
    
    recursion(a, count: 1)
    
    print(ans == Int.max ? -1 : ans)
}

/*
 더 나은 접근: B → A 역방향 탐색
 아이디어: B에서 A로 거꾸로 가면 선택지가 제한적

 B가 짝수면 → 2로 나누기 (유일한 선택)
 B가 1로 끝나면 → 1 제거 (10으로 나누기)
 둘 다 안 되면 → 불가능
 */

func _16953_greedy() {
    let ab = readLine()!.split(separator: " ").compactMap { Int($0) }
    let (a, b) = (ab[0], ab[1])
    
    var current = b
    var count = 1
    
    while current > a {
        if current % 2 == 0 {
            current /= 2
        } else if current % 10 == 1 {
            current /= 10
        } else {
            print(-1)
            return
        }
        count += 1
    }
    
    print(current == a ? count : -1)
}
