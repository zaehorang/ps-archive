//
//  main.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 4/16/24.
//  https://www.acmicpc.net/problem/10799

//MARK: - input
let steel = readLine()!

//MARK: - solve
var s = [Character]()
var cnt = 0
var before: Character = " "

for a in steel {
    
    if a == "(" {
        s.append(a)
    } else { // ")"
        if before == "(" {  // 레이저
            s.removeLast()
            cnt += s.count
            
        } else { // ")", 쇠 제거
            s.removeLast()
            cnt += 1
        }
    }
    before = a
}


//MARK: - solve 참고
/*
let input = readLine()!.map{String($0)}
var stack = 0
var cnt = 0

for i in 0..<input.count {
    if input[i] == "(" {
        stack += 1
    } else {
        stack -= 1
        if input[i-1] == "(" {
            cnt += stack
        } else {
            cnt += 1
        }
    }
}

print(cnt)
 */

//MARK: - output
print(cnt)
