//
//  main.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 4/2/24.
//  https://www.acmicpc.net/problem/2577

//MARK: - input
let a = Int(readLine()!)!
let b = Int(readLine()!)!
let c = Int(readLine()!)!

let x = String(a * b * c)

var answer = Array(repeating: 0, count: 10)

//MARK: - solve 1
// 너무 복잡해 보임 ;;;
// char -> string -> int
//for i in x {
//    let idx = Int(String(i))!
//    answer[idx] += 1
//}

//MARK: - solve 2
var y = a * b * c

while y > 0 {
    let x = y % 10
    answer[x] += 1
    y = y / 10
}

//MARK: - output
for a in answer {
    print(a)
}
