//
//  12865.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 3/31/25.
//  평범한 배낭 -> KnapSack Problem
//  https://www.acmicpc.net/problem/12865
//  풀이 참고: https://howudong.tistory.com/106

import Foundation

// 시간초과 풀이
// 모든 경우를 다 순회하기 때문에 O(n^2)
func _12865() {
    let nk = readLine()!.split(separator: " ").map { Int($0)! }
    let (n, k) = (nk[0], nk[1])
    
    var bags = [(Int, Int)]()
    
    for _ in 0..<n {
        let wv = readLine()!.split(separator: " ").map { Int($0)! }
        
        bags.append((wv[0], wv[1]))
    }
    
    var ans = 0
    
    func recursion(lastIndex: Int, val: Int, weight: Int) {
        
        // 범위를 벗어나면
        guard lastIndex < n - 1 else {
            if weight <= k {
                ans = max(ans, val)
            }
            return
        }
        
        guard weight <= k else {
            return
        }
        
        let currentIndex = lastIndex + 1
        
        recursion(lastIndex: currentIndex, val: val + bags[currentIndex].1, weight: weight + bags[currentIndex].0)
        
        recursion(lastIndex: currentIndex, val: val, weight: weight)
    }
    
    recursion(lastIndex: -1, val: 0, weight: 0)
    
    print(ans)
}

// Knapsack 알고리즘
// 시간 복잡도: O(n * w)

func _12865_DP() {
    let nk = readLine()!.split(separator: " ").map { Int($0)! }
    let (n, k) = (nk[0], nk[1])
    
    var bags = [(0, 0)]
    
    for _ in 0..<n {
        let wv = readLine()!.split(separator: " ").map { Int($0)! }
        
        bags.append((wv[0], wv[1]))
    }
    
    var dp = [[Int]](repeating: [Int](repeating: 0, count: k + 1), count: n + 1)
    
    for i in 1...n { // i번째 물품
        for j in 1...k { // 최대 무게 k 가방
            let (w, v) = (bags[i].0, bags[i].1)
            
            if w <= j { // 가방에 담을 수 있음
                dp[i][j] = max(dp[i-1][j], v + dp[i-1][j-w])
                
                
            } else { // 가방 무게 초과
                dp[i][j] = dp[i-1][j]
            }
        }
    }
    print(dp[n][k])
}
