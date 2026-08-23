//
// 1041.swift
// Swift_Algorithm
//
// Created by zaehorang on 2026/2/21.
// https://acmicpc.net/problem/1041
//

import Foundation

func _1041() {
    // Your solution here
    let n = Int(readLine()!)!
    let dice = readLine()!.split(separator: " ").compactMap { Int($0) }

    func calculateOneSide() -> Int { dice.min()! }
    func calculateTwoSide() -> Int {
        var total = 300
        
        for i in 0..<6 {
            for j in 0..<6 where j != i {
                guard (i + j) != 5 else { continue }
                total = min(total, dice[i] + dice[j])
            }
        }
        
        return total
    }
    func calculateThreeSide() -> Int {
        var total = 300
        
        for i in 0..<6 {
            for j in 0..<6
            where j != i {
                guard (i + j) != 5 else { continue }
                
                for k in 0..<6
                where k != i && k != j {
                    guard (j + k) != 5 else { continue }
                    guard (i + k) != 5 else { continue }
                    total = min(total, dice[i] + dice[j] + dice[k])
                }
            }
        }
        
        return total
    }
    func calculateFourSide() ->Int {  dice.reduce(0, +) - dice.max()! }
    
    if n == 1 {
        print(calculateFourSide())
        return
    } else {
        var total = 0
        
        total += 4 * calculateThreeSide()
        total += ((n - 1) + (n - 2)) * 4 * calculateTwoSide()
        total += ((n - 2) * (n - 2) * 5 + (n - 2) * 4) * calculateOneSide()
        
        print(total)
    }
}

func _1041_2() {
    // ✅ "수평 관계(마주보는 쌍) 최소"만으로 푸는 버전
    // 마주보는 면은 동시에 노출될 수 없으므로, 각 쌍에서 더 작은 값만 의미가 있다.
    // (A,F) (B,E) (C,D) => (0,5) (1,4) (2,3)

    let n = Int(readLine()!)!
    let d = readLine()!.split(separator: " ").map { Int($0)! }

    if n == 1 {
        // 한 개만 놓는 경우: 6면 중 가장 큰 값을 바닥으로 숨기면 5면 합이 최소
        print(d.reduce(0, +) - (d.max() ?? 0))
        return
    }

    // 1) 각 마주보는 쌍에서 최소값만 뽑기
    let p1 = min(d[0], d[5]) // A/F
    let p2 = min(d[1], d[4]) // B/E
    let p3 = min(d[2], d[3]) // C/D

    // 2) 1면/2면/3면 노출 최소 합
    let min1 = d.min() ?? 0
    let min2 = min(p1 + p2, p1 + p3, p2 + p3) // 서로 다른 두 쌍에서 하나씩
    let min3 = p1 + p2 + p3                  // 세 쌍에서 하나씩(코너)

    // 3) 노출 개수 공식
    let count3 = 4
    let count2 = 4 * (2 * n - 3)
    let count1 = 5 * (n - 2) * (n - 2) + 4 * (n - 2)

    // 4) 합
    let ans = count3 * min3 + count2 * min2 + count1 * min1
    print(ans)
}
