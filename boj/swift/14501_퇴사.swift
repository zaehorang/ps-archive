//
// 14501.swift
// Swift_Algorithm
//
// Created by zaehorang on 2026/3/3.
// https://acmicpc.net/problem/14501
//

import Foundation

func _14501() {
    // Your solution here
    typealias TC = (time: Int, cost: Int)
    
    let n = Int(readLine()!)!
    var schedule: [TC] = [(0, 0)]
    
    for _ in 0..<n {
        let tc = readLine()!.split(separator: " ").compactMap { Int($0) }
        schedule.append((tc[0], tc[1]))
    }
    
    var best = 0
    
    func recursion( _ day: Int, _ cost: Int) {
        guard day <= n else {
            best = max(best, cost)
            return
        }
        
        let today = schedule[day]
        
        if day + today.time <= n + 1 {
            recursion(day + today.time, cost + today.cost)
        }
        recursion(day + 1, cost)
    }
    
    recursion(1, 0)
    
    print(best)
}

func _14501_1() {
    // n일 동안(1...n) 상담을 선택하고, n+1일에 퇴사한다고 가정한다.
    // 목표: 퇴사 전까지 얻을 수 있는 "최대 수익"을 구하기.
    let n = Int(readLine()!)!
    
    // i일의 상담 기간/보상. 1-index로 쓰기 위해 n+2 크기로 잡는다.
    // (n+1일까지 접근할 수 있어야 dp[next]가 안전함)
    var t = Array(repeating: 0, count: n + 2)
    var p = Array(repeating: 0, count: n + 2)
    
    // 입력: i일에 (기간 t[i], 보상 p[i])
    for i in 1...n {
        let input = readLine()!.split(separator: " ").map { Int($0)! }
        t[i] = input[0]
        p[i] = input[1]
    }
    
    // dp[i] = "i일째부터 퇴사일까지" 얻을 수 있는 최대 수익
    // dp[n+1]은 더 이상 일할 수 없으므로 0(기본값)이다.
    var dp = Array(repeating: 0, count: n + 2)
    
    // 뒤에서부터 계산하는 이유:
    // dp[i]를 구하려면 미래 값(dp[i+1], dp[i + t[i]])이 필요하므로
    // i를 n -> 1로 내려오면서 채우면 이미 계산된 미래 값을 바로 참조할 수 있다.
    for i in (1...n).reversed() {
        // 선택 1) i일 상담을 "안 한다" -> 다음 날(i+1)부터의 최댓값
        dp[i] = dp[i + 1]
        
        // 선택 2) i일 상담을 "한다" -> 상담이 끝난 날(next)부터의 최댓값 + 오늘 보상
        // 단, 상담이 퇴사일(n+1)까지 끝나야 가능하다.
        let next = i + t[i]
        if next <= n + 1 {
            dp[i] = max(dp[i], p[i] + dp[next])
        }
    }
    
    // 1일째부터 시작했을 때의 최대 수익이 정답
    print(dp[1])
}

