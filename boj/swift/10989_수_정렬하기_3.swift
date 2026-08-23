//
//  10989.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 12/26/25.
//  https://www.acmicpc.net/problem/10989

import Foundation

/*
왜 이 방식(Counting Sort; 계수 정렬)이 sorted()보다 빠를 때가 많은가?

1) 시간복잡도 관점
- 일반 정렬(sorted): O(N log N)
- 카운팅 정렬(현재 코드): O(N + K)
  * N = 입력 개수
  * K = 값의 범위 (이 문제는 1...10000 이라 K=10000으로 고정)
- 따라서 N이 크고 K가 작고 고정이면, 보통 카운팅 정렬이 더 유리함.

2) 메모리 관점
- sorted(): 입력을 배열에 모두 저장한 뒤 정렬해야 하는 경우가 많음(최소 N개 저장).
- 카운팅 정렬: 실제 값들을 저장하지 않고 "빈도(count)"만 저장 가능 → 메모리 효율적.

3) 하지만 '무조건' sorted()보다 빠른 것은 아님
- K(값 범위)가 매우 크면 카운팅 배열이 커져서 메모리/시간 모두 손해.
- N이 작으면 sorted()의 상수 비용이 작아 실제로 더 빠를 수도 있음.
- Swift에서는 종종 병목이 '정렬'이 아니라 '입출력(I/O) + 문자열 생성'에 있음.
  * 예: result += ... 같은 큰 문자열 누적은 비용이 커질 수 있음.

4) 이 문제(10989)에서는 왜 특히 카운팅 정렬이 정석인가?
- 입력 N은 매우 클 수 있는데 값 범위 K는 10000으로 작고 고정.
- 그래서 대부분의 환경에서 sorted()보다 카운팅 정렬이 빠르게 통과할 확률이 높음.

정리
- "항상(sorted보다 빠름)"은 아님
- "K가 작고 고정 + N이 크면 대체로(sorted보다) 더 빠름"이 정확한 표현
*/
func _10989() {
    var cards: [Int] = .init(repeating: 0, count: 10001)

    for _ in 0..<Int(readLine()!)! {
        cards[Int(readLine()!)!] += 1
    }

    var result = ""

    for i in 1...10000 {
        result += String(repeating: "\(i)\n", count: cards[i])
    }

    print(result)
}

