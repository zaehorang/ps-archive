//
//  main.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 4/7/24.
//  https://www.acmicpc.net/problem/10773

//MARK: - input
var k = Int(readLine()!)!

//MARK: - solve
// 가장 최근 데이터를 지워야 한다.
// LIFO인 Stack 활용
var s = [Int]()

while k > 0 {
    let n = Int(readLine()!)!
    
    if n == 0 {
        // 0일 경우 지울 수 있는 수가 있음을 보장하고 있다.
        s.removeLast()
    }
    else {
        s.append(n)
    }
    
    k -= 1
}

var ans = 0
s.forEach { ans += $0 }

//MARK: - output
print(ans)
