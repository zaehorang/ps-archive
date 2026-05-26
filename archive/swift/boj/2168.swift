//
// 2168.swift
// Swift_Algorithm
//
// Created by zaehorang on 2026/2/23.
// https://acmicpc.net/problem/2168
//

import Foundation

func _2168() {
    // BOJ 2168: 타일 위의 대각선
    // 목표: 가로 x, 세로 y 타일 격자에서 (0,0) -> (x,y) 대각선이 지나가는 타일(칸) 개수 출력
    // 결론 공식: 지나가는 칸 수 = x + y - gcd(x, y)
    //
    // 왜 x + y - gcd(x, y) ?
    // 1) 대각선이 '세로 경계선'을 한 번 넘을 때마다 새로운 칸으로 이동(+1)
    //    세로 경계선은 총 (x-1)개
    // 2) 대각선이 '가로 경계선'을 한 번 넘을 때마다 새로운 칸으로 이동(+1)
    //    가로 경계선은 총 (y-1)개
    // 3) 시작 칸 1개를 포함하면 기본적으로 (x-1) + (y-1) + 1 = x + y - 1
    // 4) 하지만 대각선이 '격자 꼭짓점(교차점)'을 정확히 지나가면,
    //    세로 경계와 가로 경계를 '동시에' 넘는 순간이 생겨서 위 방식으로는 +2로 중복 카운트가 됨.
    //    이 중복 횟수만큼 1씩 빼줘야 함.
    // 5) (0,0)~(x,y) 선분이 내부에서 지나는 꼭짓점 개수는 gcd(x, y) - 1 이고,
    //    따라서 (x + y - 1) - (gcd - 1) = x + y - gcd

    // 최대공약수 (Greatest Common Divisor)
    // 유클리드 호제법: gcd(a, b) = gcd(b, a % b)
    // 나머지가 0이 되는 순간의 a(또는 x)가 최대공약수
    func gcd(_ a: Int, _ b: Int) -> Int {
        var x = a
        var y = b
        // y가 0이 될 때까지 (x, y) -> (y, x%y)로 줄여나감
        while y != 0 {
            let t = x % y
            x = y
            y = t
        }
        return x
    }

    // 입력: 한 줄에 x y
    // 예) 3 2
    let input = readLine()!.split(separator: " ").compactMap { Int($0) }
    let x = input[0]
    let y = input[1]

    // 공식 적용: x + y - gcd(x, y)
    print(x + y - gcd(x, y))
}
