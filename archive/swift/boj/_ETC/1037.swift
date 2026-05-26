//
//  1037.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 12/14/25.
//  https://www.acmicpc.net/problem/1037

import Foundation

/*
 [풀이 1] 소인수분해 기반 접근 (과한 풀이지만 논리 이해용)

 - 주어진 값들은 어떤 수 N의 '진짜 약수'들이다.
 - 모든 진짜 약수를 소인수분해한 뒤,
   각 소인수별로 가장 큰 지수만 취하면
   그 결과는 결국 원래 수 N의 소인수분해 결과와 같아진다.

 예시)
 N = 36
 진짜 약수: 2, 3, 4, 6, 9, 12, 18

 각 약수의 소인수분해:
 2  = 2^1
 3  = 3^1
 4  = 2^2
 6  = 2^1 * 3^1
 9  = 3^2
 12 = 2^2 * 3^1
 18 = 2^1 * 3^2

 → 소인수별 최대 지수:
 2^2, 3^2
 → N = 2^2 * 3^2 = 36

 즉, 모든 약수의 소인수분해 결과를 종합하면
 결국 원래 수 N을 복원할 수 있다.
 but, 약수 내에 있는 수면 소인수중 제일 작은 수를 곱해준다.
 */

func _1037() {
    let _ = Int(readLine()!)!
    
    let arr = readLine()!.split(separator: " ").map { Int($0)! }
    
    var dic: [Int: Int] = .init()
    
    for i in arr {
        var num = i
        var dic2: [Int: Int] = .init()
        
        while num != 1 {
            for k in 2...i where num % k == 0 {
                dic2[k, default: 0] += 1
                num = num / k
                break
            }
        }
        
        for (k, v) in dic2 {
            dic[k, default: 0] = max(dic[k, default: 0], v)
        }
    }
    var ans = 1
    var sk = Int.max
    
    for (k , v) in dic {
        sk = min(sk, k)
        for _ in 0..<v {
            ans *= k
        }
    }
    
    if arr.contains(ans) {
        print(ans * sk)
    } else {
        print(ans)
    }
}

/*
 [풀이 2] 최소 × 최대 (수학적 지식;)

 - 주어지는 값은 어떤 수 N의 '진짜 약수'들이다.
 - 약수는 항상 (d, N/d) 형태의 쌍으로 존재한다.
 - 진짜 약수 중 가장 작은 값 a에 대해,
   가장 큰 값은 반드시 N / a 이다.
 - 따라서:
     N = (최소 진짜 약수) × (최대 진짜 약수)

 예외:
 - N이 p^2 형태라면 진짜 약수는 p 하나뿐
   → min = max = p
   → p × p = N
   → 동일하게 성립
 
 ⭐️ 각 약수는 항상 ‘짝’ N/d 를 갖습니다
 */
func _1037_other() {
    let _ = Int(readLine()!)!
    let arr = readLine()!.split(separator: " ").map { Int($0)! }.sorted()
    
    print(arr.first! * arr.last!)
}
