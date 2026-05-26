//
// 1018.swift
// Swift_Algorithm
//
// Created by zaehorang on 2026/2/24.
// https://acmicpc.net/problem/1018
//

/*
[회고]
- 방금 풀 때는 입력 크기(N, M ≤ 50)가 작다는 점을 먼저 계산하지 않고, "연산을 최대한 줄이는 방향"으로 바로 들어갔다.
- 그래서 8x8을 전부 직접 세는(브루트포스) 풀이도 충분히 빠르다는 걸 놓치고, 슬라이딩/테이블로 최적화부터 설계하게 됐다.
- 다음에는 시작하자마자 "최악 연산량"부터 산술로 잡아보자:
  - (N-7)*(M-7)*64 ≤ 43*43*64 ≈ 118k
  - 최적화보다 구현 정확/단순함이 우선이다.
- 그래도 이번 풀이는 "한 줄(가로) 최적화" + "세로 합산"으로 아이디어를 정리해낸 점이 좋았다.
  (단, 최적화는 항상 '제약 확인 → 필요할 때만' 적용하는 습관을 들이자.)
*/

import Foundation

func _1018() {
    let nm = readLine()!.split(separator: " ").compactMap { Int($0) }
    let (n, m) = (nm[0], nm[1])

    // 핵심 아이디어(내 풀이)
    // - "가로로 8칸 창(window)을 슬라이딩"해서 각 행의 8칸 mismatch를 O(1) 갱신하도록 최적화했다.
    // - table[r][c]는 "r행에서 c부터 8칸"을
    //   'B'로 시작하는 패턴(BWBWBWBW)과 비교했을 때의 불일치(mismatch) 개수.
    //   (c는 0...(m-8)까지만 유효)
    var table: [[Int]] = .init(repeating: .init(repeating: 0, count: m), count: n)

    // 3) 각 행에 대해, 가로 8칸 mismatch를 미리 계산
    for r in 0..<n {
        let row = Array(readLine()!)

        // 시작 열 c: 0...(m-8)
        for c in 0...(m - 8) {
            if c == 0 {
                // 3-1) 첫 창(0..7)은 직접 8칸을 세어서 mismatch 개수 계산
                // 패턴: B W B W B W B W (offset이 짝수면 B, 홀수면 W)
                var count = 0
                for j in 0..<8 {
                    if j % 2 == 0 {
                        // 기대색: B
                        if row[j] != "B" { count += 1 }
                    } else {
                        // 기대색: W  (즉, 실제가 B면 mismatch)
                        if row[j] == "B" { count += 1 }
                    }
                }
                table[r][c] = count
            } else {
                // 3-2) 슬라이딩 갱신(핵심)
                // 이전 창(c-1)의 mismatch가 prev라면,
                // 창을 1칸 오른쪽으로 옮기면 겹치는 칸들의 "기대색"이 전부 뒤집혀서
                // mismatch의 맞/틀도 뒤집힌다. 그래서 기본값은 (8 - prev).
                var count = 8 - table[r][c - 1]

                // 하지만 (8 - prev)는 "이전 8칸이 그대로 남아있다"고 가정한 값이라 보정이 필요하다.
                // - 빠지는 칸: row[c-1]  (이전 창의 맨 왼쪽)
                // - 들어오는 칸: row[c+7] (새 창의 맨 오른쪽)

                // 3-2-a) 빠지는 칸의 기여 제거
                // 이전 창에서 offset=0의 기대색은 항상 'B'.
                // row[c-1]이 'B'였다면 이전 mismatch=0이었고, (8-prev)에서는 1로 뒤집혀 포함되므로 -1 보정.
                if row[c - 1] == "B" { count -= 1 }

                // 3-2-b) 새로 들어오는 칸의 기여 추가
                // 새 창에서 맨 오른쪽은 offset=7(홀수)이므로 기대색은 'W'.
                // 실제가 'B'이면 mismatch 1을 더한다.
                if row[c + 7] == "B" { count += 1 }

                table[r][c] = count
            }
        }
    }

    // 4) 이제 8x8을 세로로 쌓아서(8행 합산) 답을 구한다.
    // (i, j)를 8x8의 좌상단으로 둘 때:
    // - 짝수번째 행(offset k=0,2,4,6)은 'B'로 시작하는 행 패턴을 그대로 사용 → table[i+k][j]
    // - 홀수번째 행(offset k=1,3,5,7)은 'W'로 시작해야 하므로 mismatch는 보수(8 - table[i+k][j])
    // 이렇게 합치면 "좌상단이 B"인 8x8 repaint 수가 된다.
    var ans = 100 // 충분히 큰 값(최대 64)

    for i in 0...(n - 8) {
        for j in 0...(m - 8) {
            var count = 0

            // 좌상단이 'B'인 체스판 기준 mismatch 합
            for k in 0..<8 {
                if k % 2 == 0 {
                    count += table[i + k][j]
                } else {
                    count += (8 - table[i + k][j])
                }
            }

            // 5) 좌상단이 'W'인 패턴은 항상 보수 관계
            // - 같은 8x8에서 (B-start mismatch) + (W-start mismatch) = 64
            // 따라서 더 작은 값을 취하면 된다.
            count = min(count, 64 - count)
            ans = min(ans, count)
        }
    }

    print(ans)
}


func _1018_1() {
    let nm = readLine()!.split(separator: " ").compactMap { Int($0) }
    let n = nm[0]
    let m = nm[1]

    var board: [[Character]] = []

    for _ in 0..<n {
        board.append(Array(readLine()!))
    }

    func countMismatchWStart(_ i: Int, _ j: Int) -> Int {
        var cnt = 0
        for x in 0..<8 {
            for y in 0..<8 {
                let shouldBe: Character = ((x + y) % 2 == 0) ? "W" : "B"
                if board[i + x][j + y] != shouldBe { cnt += 1 }
            }
        }
        return cnt
    }

    var ans = Int.max

    for i in 0...(n - 8) {
        for j in 0...(m - 8) {
            let wStart = countMismatchWStart(i, j)
            ans = min(ans, min(wStart, 64 - wStart))
        }
    }

    print(ans)
}
