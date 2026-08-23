//
// 2210.swift
// Swift_Algorithm
//
// Created by zaehorang on 2026/3/6.
// https://acmicpc.net/problem/2210
//

import Foundation

func _2210() {
    // Your solution here
    typealias Point = (x: Int, y: Int)
    
    var table: [[Int]] = []
    var set: Set<String> = []
    for _ in 0..<5 {
        table.append(
            readLine()!.split(separator: " ").compactMap { Int($0) }
        )
    }
    
    let dx = [0, 1, 0, -1]
    let dy = [1, 0, -1, 0]
    
    func recursion(_ point: Point, _ current: String, _ count: Int) {
        guard count < 6 else {
            set.insert(current)
            return
        }
        
        for i in 0..<dx.count {
            let nx = point.x + dx[i]
            let ny = point.y + dy[i]
            
            if nx < 0 || nx >= 5 || ny < 0 || ny >= 5 { continue }
            
            recursion(
                (nx, ny),
                current + String(table[nx][ny]),
                count + 1
            )
        }
    }
    
    for i in 0..<5 {
        for j in 0..<5 {
            recursion((i, j), String(table[i][j]), 1)
        }
    }
    print(set.count)
}
