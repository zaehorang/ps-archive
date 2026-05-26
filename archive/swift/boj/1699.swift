//
// 1699.swift
// Swift_Algorithm
//
// Created by zaehorang on 2026/3/16.
// https://acmicpc.net/problem/1699
//

import Foundation

/*
 그리디(현재 수에서 가장 큰 제곱수를 계속 빼는 방식)라서 틀린 풀이
 
 이 문제는 매 순간 가장 큰 제곱수를 고르는 선택이
 전체 제곱수 개수의 최솟값을 보장하지 않는다.
 
 예를 들어 12는
 12 = 9 + 1 + 1 + 1  -> 4개
 보다
 12 = 4 + 4 + 4      -> 3개
 가 더 최적이다.
 
 따라서 "지금 가장 큰 제곱수"를 고르는 방식으로는
 항상 최적해를 구할 수 없다.
 */
func _1699() {
    // Your solution here
    let n = Int(readLine()!)!
    
    var target = n
    var ans = 0
    
    while true {
        print(target)
        guard target > 0 else {
            print(ans)
            return
        }
        
        let new = Int(Double(target).squareRoot())
        ans += 1
        
        target -= (new * new)
    }
}

/*
 시간초과 나는 풀이
 
 dp[i]를 구할 때 i = x + y 로 모든 분할을 확인한다.
 즉, i마다 1...(i / 2) 를 전부 돌아야 하므로
 전체 시간 복잡도가 거의 O(n^2) 이 된다.
 
 하지만 이 문제의 핵심은 "마지막에 사용한 제곱수 하나"를 보는 것이다.
 그래서 모든 분할을 볼 필요 없이,
 j*j <= i 인 제곱수만 확인하면 된다.
 
 즉,
 _1699_1()은 불필요하게 너무 많은 경우를 확인해서 시간초과가 난다.
 */
func _1699_1() {
    // Your solution here
    let n = Int(readLine()!)!
    
    guard n > 1 else {
        print(1)
        return
    }
    
    var dp: [Int] = .init(repeating: 0, count: n + 1)
    dp[1] = 1
    
    func isSquareN(_ n: Int) -> Bool {
        let a = Int(Double(n).squareRoot())
        return a * a == n
    }
    
    for i in 2...n {
        guard !isSquareN(i) else {
            dp[i] = 1
            continue
        }
        var count = Int.max
        
        for x in 1...(i/2) {
            let y = i - x
            count = min(count, dp[x] + dp[y])
        }
        dp[i] = count
    }
    print(dp[n])
}

/*
 dp[i] = i를 제곱수들의 합으로 나타낼 때 필요한 최소 개수
 
 i를 만들 때, 마지막에 사용하는 제곱수를 j*j라고 생각한다.
 그러면 남은 값은 i - j*j 이고,
 i를 만드는 최소 개수는 dp[i - j*j] + 1 중 최솟값이 된다.
 
 점화식:
 dp[i] = min(dp[i - j*j] + 1)   (단, j*j <= i)
 */
func _1699_2() {
    // Your solution here
    let n = Int(readLine()!)!
    var dp: [Int] = .init(repeating: 0, count: n + 1)

    for i in 1...n {
        var count = Int.max
        for j in 1...Int(Double(i).squareRoot()) {
            count = min(count, dp[i-j*j] + 1)
        }
        dp[i] = count
    }
    print(dp[n])
}
