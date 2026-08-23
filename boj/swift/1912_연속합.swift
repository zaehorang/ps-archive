//
// 1912.swift
// Swift_Algorithm
//
// Created by zaehorang on 2026/3/19.
// https://acmicpc.net/problem/1912
//

import Foundation

// 기존에 작성한 풀이 (오른쪽 -> 왼쪽 순회)
//
// 핵심 아이디어
// - current: 현재 위치에서 시작했을 때, 오른쪽으로 이어 붙여 볼 만한 연속합
// - total: 지금까지 확인한 최대 연속합
//
// 배열을 뒤에서부터 보면서,
// 1) 양수는 이어 붙이는 것이 이득일 수 있으므로 current에 더한다.
// 2) 음수는 current와 더했을 때 아직 양수라면 유지하고,
//    0 이하가 되면 그 뒤 구간은 버리고 다시 시작한다.
// 3) 매 단계에서 단일 원소 값과 이어 붙인 값 중 최댓값을 total에 반영한다.
//
// 즉, 오른쪽 구간을 보며 "이 구간이 앞으로도 이어질 가치가 있는가?"를 판단한 풀이이다.
func _1912() {
    // 뒤에서부터 보면서 오른쪽 구간의 연속합을 관리한다.
    // 음수를 만났을 때 누적합이 0 이하가 되면, 그 구간은 앞으로 붙여도 이득이 없다고 보고 버린다.
    let n = Int(readLine()!)!
    let nums = readLine()!.split(separator: " ").compactMap { Int($0) }
    
    var total = Int.min
    var current = 0
    
    for i in stride(from: n - 1, through: 0, by: -1) {
        // 현재 값을 시작점으로 봤을 때, 오른쪽 구간과 이어 붙일지 판단한다.
        let value = nums[i]
        total = max(total, value)
        
        // 음수라면 이어 붙였을 때 아직 양수인지 확인한다.
        if value < 0 {
            let new = current + value
            
            if new > 0 { // 갈만하다.
                current = new
            } else {
                current = 0
            }
        // 양수라면 이어 붙이는 편이 유리하므로 current에 더한다.
        } else {
            current += value
            total = max(total, current)
        }
    }
    
    print(total)
}

// 정석적인 카데인 알고리즘(Kadane's Algorithm) 풀이
//
// 핵심 아이디어
// - current: 현재 인덱스에서 "끝나는" 최대 연속합
// - answer: 지금까지 나온 최대 연속합의 최댓값
//
// i번째 값을 볼 때 선택지는 2개뿐이다.
// 1) 이전 연속합을 버리고 nums[i]부터 새로 시작한다.
// 2) 이전에 만들었던 연속합 뒤에 nums[i]를 이어 붙인다.
//
// 따라서 점화식은 아래처럼 된다.
// current = max(nums[i], current + nums[i])
// answer = max(answer, current)
//
// 예를 들어 current가 음수라면,
// 그 뒤에 어떤 수를 붙여도 오히려 손해일 가능성이 크므로
// 현재 값 하나로 새로 시작하는 편이 더 낫다.
// 반대로 current가 양수라면 이어 붙이는 것이 이득일 수 있다.
func _1912_1() {
    let n = Int(readLine()!)!
    let nums = readLine()!.split(separator: " ").compactMap { Int($0) }

    // 첫 번째 값 하나만 선택한 상태로 시작한다.
    // 이 문제는 수를 최소 1개는 반드시 선택해야 하므로
    // 0이 아니라 nums[0]으로 시작해야 음수만 있는 경우도 올바르게 처리된다.
    var current = nums[0]
    var answer = nums[0]

    for i in 1..<n {
        // 현재 위치에서 끝나는 최대 연속합
        // - nums[i]부터 새로 시작하거나
        // - 이전 연속합 뒤에 nums[i]를 붙이는 경우 중 더 큰 값을 선택한다.
        current = max(nums[i], current + nums[i])

        // 각 위치에서 끝나는 최대 연속합들 중 가장 큰 값을 전체 정답으로 유지한다.
        answer = max(answer, current)
    }

    print(answer)
}
