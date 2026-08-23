//
// 1153.swift
// Swift_Algorithm
//
// Created by zaehorang on 2026/2/14.
// https://acmicpc.net/problem/1153
//

/*
 [BOJ 1153 - 네 개의 소수] 개념 정리

 0) 에라토스테네스의 체(Sieve of Eratosthenes)
    - 2부터 N까지 소수 여부를 한 번에 구하는 대표적인 방법
    - isPrime[0] = false, isPrime[1] = false 로 시작
    - i를 2부터 √N까지 돌면서, i가 소수라면 i의 배수들을 모두 지운다(false)
      * 이때 j를 i*i부터 시작하는 이유:
        i보다 작은 수의 배수는 이전 단계에서 이미 지워졌기 때문
    - 시간복잡도: O(N log log N), 메모리: O(N)

 1) 존재 조건
    - 가장 작은 소수 4개의 합: 2+2+2+2 = 8
    - 따라서 N < 8 이면 불가능 → -1

 2) 골드바흐 아이디어(핵심)
    - (참고) "모든 짝수(4 이상)는 두 소수의 합"이라는 명제는
      '강한 골드바흐 추측'으로 수학적으로는 아직 완전 증명되지 않았다.
    - 하지만 이 문제에서는 체로 소수표를 만든 뒤 실제로 (k = p + q)를 탐색해서
      소수 쌍을 찾아 출력하므로, '가정'이 아니라 '검증/탐색'으로 해결한다.

    - (추가 참고) "모든 홀수(5 초과)는 세 소수의 합"(약한 골드바흐)은 증명되었지만,
      이 문제는 4개의 소수를 출력해야 하므로 아래의 변형을 사용한다.

 3) 앞의 두 소수 고정 (문제 풀이 트릭)
    - N이 짝수면: 2, 2를 먼저 사용 → 남은 값 k = N - 4 (짝수)
    - N이 홀수면: 2, 3을 먼저 사용 → 남은 값 k = N - 5 (짝수)

    이렇게 하면 항상 "짝수 k"를 "두 소수의 합 p + q"로만 찾으면 된다.

 4) k를 두 소수로 분해
    - 에라토스테네스의 체로 0...N 범위 소수 판별 배열을 만든다.
    - i를 2...k/2 까지 돌며 isPrime[i] && isPrime[k-i] 인 쌍을 찾는다.

 5) 시간 복잡도
    - 체: O(N log log N)
    - 쌍 탐색: O(N)

 출력 형식: (고정한 두 수) + (찾은 p, q)
*/
import Foundation

func _1153() {
    // Your solution here
    let n = Int(readLine()!)!
    guard n >= 8 else {
        print(-1)
        return
    }
    
    var prime: [Bool] = .init(repeating: true, count: n + 1)
    
    for i in 2...n {
        guard i * i <= n else { break }
        guard prime[i] else { continue }
        
        for j in 2...n {
            let idx = i * j
            guard idx < n else { break }
            prime[idx] = false
        }
    }
    
    var ans = ""
    var k = 0
    
    if (n - 4) % 2 == 0 {
        ans += "2 2 "
        k = n - 4
    } else {
        ans += "2 3 "
        k = n - 5
    }
    for i in 2...k {
        if prime[i] && prime[k-i] {
            ans += "\(i) \(k-i)"
            break
        }
    }
    print(ans)
}

func _1153_1() {
    let n = Int(readLine()!)!
    
    // 최소: 2+2+2+2 = 8
    guard n >= 8 else {
        print(-1)
        return
    }
    
    // 에라토스테네스의 체 (O(n log log n))
    var isPrime = Array(repeating: true, count: n + 1)
    isPrime[0] = false
    isPrime[1] = false
    
    
    var i = 2
    while i * i <= n {
        if isPrime[i] {
            var j = i * i // i보다 작은 수는 이미 이전에 다 봤기 때문
            while j <= n {
                isPrime[j] = false
                j += i
            }
        }
        i += 1
    }
    
    // n의 홀짝에 따라 앞의 두 소수를 고정해서, 남은 값 k를 '짝수'로 만든다
    let first: Int
    let second: Int
    let k: Int
    
    if n % 2 == 0 {
        first = 2
        second = 2
        k = n - 4
    } else {
        first = 2
        second = 3
        k = n - 5
    }
    
    // k = p + q (둘 다 소수) 찾기
    var p = -1
    var q = -1
    
    // i는 k/2까지만 보면 충분
    for i in 2...(k / 2) {
        if isPrime[i] && isPrime[k - i] {
            p = i
            q = k - i
            break
        }
    }
    
    print("\(first) \(second) \(p) \(q)")
}
