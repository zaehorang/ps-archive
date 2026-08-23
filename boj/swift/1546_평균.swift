//
//  1546.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 12/22/25.
//  https://www.acmicpc.net/problem/1546

func _1546() {
    let N = Double(readLine()!)!
    
    var maxPoint:Double = 0
    
    let points: [Double] = readLine()!
        .split(separator: " ")
        .map {
            let n = Double($0)!
            maxPoint = max(maxPoint, n)
            
            return n
        }
    
    let total = points.map { $0 / maxPoint * 100 }.reduce(0, +)
    
    print(total / N)
}
