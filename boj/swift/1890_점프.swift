//
// 1890.swift
// Swift_Algorithm
//
// Created by zaehorang on 2026/2/19.
// https://acmicpc.net/problem/1890
//

import Foundation

/// 시간 초과
///  (+) 애초에 틀림; 문제에 마지막 장소만 0인 줄 알았는데 중간중간 0이 껴있을 수 있음
///  예제만 보고 확신하지 말자.
func _1890() {
    // Your solution here
    let n = Int(readLine()!)!
    var table: [[Int]] = []
    
    for _ in 0..<n {
        table.append(
            readLine()!.split(separator: " ").compactMap { Int($0) }
        )
    }
    
    var stack = [(0, 0)]
    var ans = 0
    
    while !stack.isEmpty {
        let p = stack.removeLast()
        let x = p.0, y = p.1
        
        guard x >= 0 && x < n else { continue }
        guard y >= 0 && y < n else { continue }
        
        guard table[x][y] != 0 else {
            ans += 1
            continue
        }
        
        let d = table[x][y]
        
        stack.append((x + d, y))
        stack.append((x, y + d))
    }
    print(ans)
}

/// 그냥 풀었는데 이게 DP Top-down 방식이래요..
func _1890_1() {
    // Your solution here
    let n = Int(readLine()!)!
    var table: [[Int]] = []
    
    for _ in 0..<n {
        table.append(
            readLine()!.split(separator: " ").compactMap { Int($0) }
        )
    }
    
    var visited: [[Int]] = .init(repeating: .init(repeating: 0, count: n), count: n)
    
    func recursion(_ p: (Int, Int)) -> Int {
        let x = p.0, y = p.1
        
        guard x >= 0 && x < n else { return 0 }
        guard y >= 0 && y < n else { return 0 }
        
        if x == n - 1 && y == n - 1 { return 1 }
        
        guard table[x][y] != 0 else { return 0 }
        
        guard visited[x][y] == 0 else { return visited[x][y] }

        let d = table[x][y]
        
        visited[x][y] += recursion((x + d, y))
        visited[x][y] += recursion((x, y + d))
        return visited[x][y]
    }
    print(recursion((0, 0)))
}


/// Bottom-Up DP (반복문)
/// dp[x][y] = (x,y)까지 도달하는 경우의 수
/// dp[0][0] = 1에서 시작해서, 현재 칸의 점프 길이만큼 아래/오른쪽으로 누적
func _1890_bottomUp() {
    let n = Int(readLine()!)!
    var table: [[Int]] = []
    table.reserveCapacity(n)

    for _ in 0..<n {
        table.append(readLine()!.split(separator: " ").compactMap { Int($0) })
    }

    var dp: [[Int]] = .init(repeating: .init(repeating: 0, count: n), count: n)
    dp[0][0] = 1

    for x in 0..<n {
        for y in 0..<n {
            let ways = dp[x][y]
            if ways == 0 { continue }

            // 도착 칸에서는 더 진행하지 않음
            if x == n - 1 && y == n - 1 { continue }

            let d = table[x][y]
            if d == 0 { continue }

            let nx = x + d
            let ny = y + d

            if nx < n { dp[nx][y] += ways }
            if ny < n { dp[x][ny] += ways }
        }
    }

    print(dp[n - 1][n - 1])
}
