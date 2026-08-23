//
//  main.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 4/5/24.
//  https://www.acmicpc.net/problem/5397

//MARK: - input
var n = Int(readLine()!)!

//MARK: - solve

var ans: [String] = []

while n > 0 {
    
    // Stack 2개 생성
    var left: [Character] = []
    var right: [Character] = []
    
    let input = readLine()!
    
    
    for a in input {
        
        if a == "<" {  // 커서 왼쪽 이동
            if !left.isEmpty {
                right.append(left.removeLast())
            }
        }
        else if a == ">" {  // 커서 오른쪽 이동
            if !right.isEmpty {
                left.append(right.removeLast())
            }
        }
        else if a == "-" {  // 지우기
            var _ = left.popLast()
        }
        else {  // 문자 입력
            left.append(a)
        }
    }
    
    ans.append(String(left + right.reversed()))
    
    n -= 1
}

//MARK: - output
for a in ans {
    print(a)
}
