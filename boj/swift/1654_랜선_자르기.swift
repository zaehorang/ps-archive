//
// 1654.swift
// Swift_Algorithm
//
// Created by zaehorang on 2026/4/8.
// https://acmicpc.net/problem/1654
//

import Foundation

/// 잘못된 이분 탐색 풀이
///
/// 왜 틀렸는가?
/// 1. 이분 탐색은 `left...right`처럼 정답이 존재할 수 있는 구간을 유지하며 좁혀야 한다.
///    그런데 이 풀이는 `target` 하나만 바꾸기 때문에, 어떤 구간이 유효하고
///    어떤 구간이 이미 버려졌는지 보장되지 않는다.
/// 2. `count >= n`일 때 `target = (target + maxLine) / 2`로 이동하는 방식은
///    현재 길이로 가능하니 더 긴 길이도 되는지 확인하려는 의도지만,
///    하한 경계 정보가 없어서 이미 확인한 구간을 다시 포함할 수 있다.
/// 3. `count < n`일 때 `target = (target + 1) / 2`로 줄이는 방식도 마찬가지로
///    상한만 줄일 뿐, 직전의 가능/불가능 경계를 기록하지 않아
///    최대 길이를 정확히 찾는다는 보장이 없다.
/// 4. `if n < lines.reduce(0, { $0 + $1 / target + 1 })`는
///    `(target + 1)` 길이로 잘랐을 때의 개수를 구하는 식이 아니다.
///    현재 식은 각 랜선마다 `+1`이 더해져 실제 개수보다 크게 계산되므로
///    종료 조건 자체가 잘못되었다.
///
/// 즉, 이 풀이는 "가능/불가능의 경계"를 추적하는 이분 탐색이 아니라
/// `target`을 감으로 조정하는 방식이라 반례에서 틀릴 수 있다.
func _1654() {
    let kn = readLine()!.split(separator: " ").compactMap { Int($0) }
    let (k, n) = (kn[0], kn[1])

    var maxLine = 0

    let lines = (0..<k).map { _ in
        let a = Int(readLine()!)!
        maxLine = max(maxLine, a)
        return a
    }

    // 문제점 1:
    // 이분 탐색은 `left`, `right` 범위를 함께 관리해야 하는데,
    // 여기서는 `target` 하나만 움직여서 경계 정보가 사라진다.
    var target = maxLine
    var ans = 0

    // 문제점 2:
    // 종료 조건도 `left <= right`처럼 명확한 범위 기반이 아니라,
    // 특정 계산식이 맞기를 기대하며 `break`에 의존하고 있다.
    while true {
        print(target)
        let count = lines.reduce(0) { $0 + $1 / target }

        if count >= n {
            ans = target

            // 문제점 3:
            // 이 식은 `(target + 1)` 길이로 잘랐을 때의 개수를 구하는 식이 아니다.
            // 현재는 각 랜선마다 `+1`이 더해져 실제 개수보다 크게 계산된다.
            // 즉, 종료 조건이 잘못되어 정답을 보장할 수 없다.
            if n < lines.reduce(0, { $0 + $1 / target + 1 }) {
                break
            }

            // 문제점 4:
            // 가능한 경우에도 `left = mid + 1`처럼 하한을 올리는 것이 아니라,
            // 단순 평균으로 이동해서 최대 가능한 길이의 경계를 정확히 좁히지 못한다.
            target = (target + maxLine) / 2
        } else {
            // 문제점 5:
            // 불가능한 경우에도 `right = mid - 1`처럼 상한을 줄여야 하는데,
            // 현재 방식은 경계 없이 값을 줄이기만 해서 반례에서 틀릴 수 있다.
            target = (target + 1) / 2
        }
    }

    print(ans)
}


func _1654_1() {
    let kn = readLine()!.split(separator: " ").map { Int($0)! }
    let (k, n) = (kn[0], kn[1])

    var left = 1
    var right = 0
    
    let lines = (0..<k).map { _ in
        let a = Int(readLine()!)!
        right = max(right, a)
        
        return a
    }

    var answer = 0

    while left <= right {
        let mid = (left + right) / 2
        let count = lines.reduce(0) { $0 + $1 / mid }

        if count >= n {
            answer = mid
            left = mid + 1
        } else {
            right = mid - 1
        }
    }

    print(answer)
}
