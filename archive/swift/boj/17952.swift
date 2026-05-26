//
// 17952.swift
// Swift_Algorithm
//
// Created by zaehorang on 2026/3/10.
// https://acmicpc.net/problem/17952
//

import Foundation

func _17952() {
    // Your solution here
    typealias AT = (point: Int, time: Int)
    
    let n = Int(readLine()!)!
    
    var ans = 0
    
    var stack: [AT] = []
    var current: AT?
    
    for _ in 0..<n {
        let homework = readLine()!.split(separator: " ").compactMap { Int($0) }
        
        if homework[0] == 1 {
            let new = (homework[1], homework[2])
            
            if let cur = current { stack.append(cur) }
            
            current = new
        }
        
        current?.time -= 1
        
        if current?.time == 0 {
            ans += current?.point ?? 0
            
            current = stack.popLast()
        }
    }
    
    print(ans)
}



func _17952_1() {
    typealias Homework = (score: Int, remain: Int)

    let n = Int(readLine()!)!
    var answer = 0
    var stack: [Homework] = []

    for _ in 0..<n {
        let input = readLine()!.split(separator: " ").map { Int($0)! }

        // 새 과제가 들어오면 바로 시작
        if input[0] == 1 {
            stack.append((score: input[1], remain: input[2]))
        }

        // 현재 진행 중인 과제(스택 top)를 1분 수행
        if !stack.isEmpty {
            stack[stack.count - 1].remain -= 1

            if stack[stack.count - 1].remain == 0 {
                answer += stack.removeLast().score
            }
        }
    }

    print(answer)
}
