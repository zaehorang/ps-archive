//
// 1025.swift
// Swift_Algorithm
//
// Created by zaehorang on 2026/3/9.
// https://acmicpc.net/problem/1025
//

import Foundation

func _1025() {
    let nm = readLine()!.split(separator: " ").map { Int($0)! }
    let (n, m) = (nm[0], nm[1])

    var board: [[Int]] = []
    for _ in 0..<n {
        board.append(readLine()!.map { Int(String($0))! })
    }

    func isPerfectSquare(_ value: Int) -> Bool {
        guard value >= 0 else { return false }
        let root = Int(Double(value).squareRoot())
        return root * root == value || (root + 1) * (root + 1) == value
    }

    var answer = -1

    for sr in 0..<n {
        for sc in 0..<m {
            
            for dr in -(n - 1)...(n - 1) {
                for dc in -(m - 1)...(m - 1) {
                    if dr == 0 && dc == 0 { continue }

                    var r = sr
                    var c = sc
                    var number = 0

                    while r >= 0 && r < n && c >= 0 && c < m {
                        number = number * 10 + board[r][c]

                        if isPerfectSquare(number) {
                            answer = max(answer, number)
                        }

                        r += dr
                        c += dc
                    }
                }
            }

            let oneDigit = board[sr][sc]
            if isPerfectSquare(oneDigit) {
                answer = max(answer, oneDigit)
            }
        }
    }

    print(answer)
}
