//
//  main.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 4/18/24.
//  https://www.acmicpc.net/problem/2504

//MARK: -  input
let str = readLine()!

//MARK: - solve
var n = 1
var ans = 0
var prev: Character = " "

// Stack
var s = [Character]()

for a in str {

    if a == "(" {
        
        s.append(a)
        n *= 2
        
    } else if a == ")" {

        if prev == "(" {
            s.removeLast()
            
            ans += n
            n /= 2
        } else {
            
            guard let last = s.last, last == "(" else { // 괄호쌍 조건
                ans = 0
                break
            }
            s.removeLast()
            n /= 2
        }
        
    } else if a == "[" {
        
        s.append(a)
        n *= 3
        
    } else {  // "]"
        
        if prev == "[" {
            s.removeLast()
            
            ans += n
            n /= 3
        } else {
            
            guard let last = s.last, last == "[" else { // 괄호쌍 조건
                ans = 0
                break
            }
            s.removeLast()
            n /= 3
        }
        
    }
    
    prev = a
    
}

//MARK: - output
// 배열 관련 문제에서 최종적으로 배열이 다 비어있는지도 확인 필수
// 괄호처럼 모든 짝이 있어야 하는 경우 ❗️
// ()((((()

if s.isEmpty {
    print(ans)
} else {
    print(0)
}

// ()((((()

