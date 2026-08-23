//
//  17182.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 1/9/26.
//  https://www.acmicpc.net/problem/17182

import Foundation

func _17182() {
    let NK = readLine()!.split(separator: " ").compactMap { Int($0) }
    let (N, K) = (NK[0], NK[1])
    
    var time = [[Int]]()
    var route: [[Int]] = .init(repeating: Array(0..<N), count: N)
    
    for _ in 0..<N {
        time.append(readLine()!.split(separator: " ").compactMap { Int($0) })
    }
    
    for k in 0..<N {
        for i in 0..<N {
            for j in 0..<N {
                let new = time[i][k] + time[k][j]
                if time[i][j] > new {
                    time[i][j] = new
                    route[i][j] = route[i][k]
                }
            }
        }
    }
    
    var ans = Int.max
    var vistedTable: [Bool] = .init(repeating: false, count: N)
    vistedTable[K] = true
    
    func recursion(_ n: Int, _ cost: Int, _ current: Int, _ isVisted: [Bool]) {
        guard n < N else {
            ans = min(cost, ans)
            return
        }
        
        for next in 0..<N where !isVisted[next] {
            var copy = isVisted
            copy[next] = true
            
            var r = route[current][next]
            copy[r] = true
            
            while next != r {
                r = route[r][next]
                copy[r] = true
            }
            
            recursion(n + 1, cost + time[current][next], next, copy)
        }
        
    }
    
    recursion(1, 0, K, vistedTable)
    print(ans)
}

// Optimized solution (no FastScanner): Floyd-Warshall + Bitmask DP
func _17182_opt() {
    let NK = readLine()!.split(separator: " ").compactMap { Int($0) }
    let (N, K) = (NK[0], NK[1])

    var time = [[Int]]()
    for _ in 0..<N {
        time.append(readLine()!.split(separator: " ").compactMap { Int($0) })
    }

    // 1) Floyd-Warshall
    for k in 0..<N {
        for i in 0..<N {
            for j in 0..<N {
                let cand = time[i][k] + time[k][j]
                if time[i][j] > cand { time[i][j] = cand }
            }
        }
    }

    // 2) Bitmask DP (TSP path)
    let INF = Int.max / 4
    let full = (1 << N) - 1  // - 1을 하면, 그 아래 비트들이 전부 1로 채워집니다.
    var dp = Array(repeating: Array(repeating: INF, count: N), count: 1 << N)
    dp[1 << K][K] = 0

    for mask in 0...full {
        for cur in 0..<N {
            let curCost = dp[mask][cur]
            if curCost == INF { continue }

            // next 비트가 0이라는 뜻 → 아직 방문 안 했다
            for next in 0..<N where (mask & (1 << next)) == 0 {
                let nmask = mask | (1 << next)
                let ncost = curCost + time[cur][next]
                if dp[nmask][next] > ncost {
                    dp[nmask][next] = ncost
                }
            }
        }
    }

    var ans = INF
    for i in 0..<N {
        ans = min(ans, dp[full][i])
    }
    print(ans)
}
