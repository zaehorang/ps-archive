//
// 2805.swift
// Swift_Algorithm
//
// Created by zaehorang on 2026/3/30.
// https://acmicpc.net/problem/2805
//

import Foundation


// 정렬 기반 풀이
// 시간복잡도: O(N log N)
// - 나무 높이 정렬: O(N log N)
// - 이후 한 번 순회: O(N)
func _2805() {
    // Your solution here
    let nm = readLine()!.split(separator: " ").compactMap { Int($0) }
    let (n, m) = (nm[0], nm[1])
    
    let trees = readLine()!
        .split(separator: " ")
        .compactMap { Int($0) }
        .sorted(by: >)
    
    // 전체적으로 정렬이 가장 크므로 최종 시간복잡도는 O(N log N)
    var dp: [Int] = .init(repeating: 0, count: n)
    
    for i in 1..<n {
        let new = dp[i-1] + (trees[i-1] - trees[i]) * i
        dp[i] = new
        
        if new >= m {
            let extra = new - m
            print(trees[i] + extra / i)
            return
        }
    }
    
    // 가장 작은 나무보다 더 낮게 잘라야 하는 경우
    let need = m - dp[n - 1]
    print(trees[n - 1] - (need + n - 1) / n)
    // (need + n - 1) / n == ceil(need / n) 과 같은 올림 계산
}

// 이분 탐색 정석 풀이
// 시간복잡도: O(N log H)
// - H: 가장 큰 나무 높이
// - 매 탐색마다 모든 나무를 확인: O(N)
// - 높이 범위를 이분 탐색: O(log H)
func _2805_1() {
    let nm = readLine()!.split(separator: " ").compactMap { Int($0) }
    let n = nm[0]
    let m = nm[1]

    let trees = readLine()!.split(separator: " ").compactMap { Int($0) }

    // 정렬이 필요 없어서 보통 이 풀이를 더 효율적인 정석 풀이로 본다.
    var left = 0
    var right = trees.max()!
    var answer = 0

    while left <= right {
        let mid = (left + right) / 2
        var total = 0

        for tree in trees {
            if tree > mid {
                total += tree - mid
            }
        }

        if total >= m {
            answer = mid
            left = mid + 1
        } else {
            right = mid - 1
        }
    }

    print(answer)
}
