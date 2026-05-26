//
//  main.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 4/2/24.
//  https://www.acmicpc.net/problem/1475

//MARK: - input
var n = Int(readLine()!)!
var ans = Array(repeating: 0, count: 10)

//MARK: - solve
while n > 0 {
    let i = n % 10
//
//    if i == 9 {
//        ans[6] += 1
//        n /= 10
//        continue
//    }
    
    ans[i] += 1
    
    n /= 10
}

// Int는 버림
ans[6] = (ans[6] + ans[9] + 1) / 2

//MARK: - output
print(ans.max()!)
