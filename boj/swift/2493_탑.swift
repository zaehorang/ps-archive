//
//  main.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 4/8/24.
//  https://www.acmicpc.net/problem/2493

//MARK: - input
let n = Int(readLine()!)!
let tops = readLine()!.split(separator: " ").map { Int($0)! }

//MARK: - solve
var s = [(Int, Int)]()
var ans = [Int]()

for (idx, a) in tops.enumerated() {
    
    if s.isEmpty {  // 나보다 큰 탑이 없음
        s.append((idx, a))
        ans.append(0)
    } else {
        while !s.isEmpty {
            let (i, b) = s.removeLast()
            
            if b >= a {  // 자신보다 큰 탑을 찾았을 경우
                ans.append(i + 1)
                s.append((i, b))
                s.append((idx, a))
                break
            }
            
        }
        // 자신보다 큰 탑을 못찾고 while문 탈출
        if s.isEmpty {
            ans.append(0)
            s.append((idx, a))
        }
    }
}


//MARK: - output
// 정답 끝에 공백 있어도 가능
//ans.forEach {
//    print($0, terminator: " ")
//}

print(ans.map { String($0) }.joined(separator: " "))
