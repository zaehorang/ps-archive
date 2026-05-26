//
// 11053.swift
// Swift_Algorithm
//
// Created by zaehorang on 2026/2/26.
// https://acmicpc.net/problem/11053
//

import Foundation

func _11053() {
    // ⚠️ 오답 풀이 메모
    // 이 코드는 dp를 "최장 증가 부분 수열(LIS)"로 계산하지 못합니다.
    // 핵심 문제:
    // 1) LIS는 i 다음 원소를 "바로" 선택할 필요가 없고(부분 수열이라 건너뛰기 가능),
    //    i 이후의 모든 후보 j(i<j<n) 중에서 최선(dp[j])을 골라야 합니다.
    // 2) 그런데 아래 코드는
    //    - nums[i] < nums[i+1] 이면 무조건 i+1을 다음으로 선택(dp[i]=dp[i+1]+1)하고,
    //    - 그렇지 않으면 "처음 만나는" nums[j] > nums[i] 하나만 고르고 break 합니다.
    //    => 즉, 모든 j를 보며 max를 취하지 않는 '그리디'라서 반례가 생깁니다.
    // 3) 예: 5 1 2 3 4
    //    큰 수(5)를 먼저 잡으면 길이 1이 되지만, 정답은 1 2 3 4 (길이 4).
    //
    // 정답 접근: dp[i] = i번째 원소로 '끝나는' LIS 길이
    // dp[i] = max(dp[j] + 1) for all j < i with nums[j] < nums[i]
    let n = Int(readLine()!)!
    
    let nums = readLine()!.split(separator: " ").compactMap { Int($0) }
    var dp: [Int] = .init(repeating: 1, count: n)
    
    for i in (0..<(n-1)).reversed() {
        if nums[i] < nums[i + 1] {
            dp[i] = dp[i + 1] + 1
        } else {
            for j in (i+1)..<n {
                guard nums[j] > nums[i] else { continue }
                dp[i] = dp[j] + 1
                break
            }
        }
    }
    print(dp.max()!)
}

func _11053_1() {
    // 정답 풀이 (O(n^2) DP)
    // dp[i] = i번째 원소(nums[i])로 끝나는 최장 증가 부분 수열의 길이

    let n = Int(readLine()!)!
    let nums = readLine()!.split(separator: " ").compactMap { Int($0) }

    var dp = Array(repeating: 1, count: n)

    // i를 마지막 원소로 두고, 그 이전(j<i)에서 nums[j] < nums[i]인 것들을 이어붙여 최댓값을 갱신
    for i in 0..<n {
        for j in 0..<i {
            if nums[j] < nums[i] {
                dp[i] = max(dp[i], dp[j] + 1)
            }
        }
    }

    print(dp.max()!)
}
