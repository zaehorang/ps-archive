//
//  15649.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 6/24/24.
//  https://www.acmicpc.net/problem/15649
//  N과 M (1)

// 1~n에서 m개 뽑기
func _15649() {
    let nm = readLine()!.split(separator: " ").map { Int($0)! }
    let n = nm[0]
    let m = nm[1]
    
    var arr: [Int] = .init(repeating: 0, count: m)
    var isUsed: [Bool] = .init(repeating: false, count: n + 1)
    
    recursion_15649(k: 0)
    
    func recursion_15649(k: Int) {
        if k == m {
            arr.forEach { print($0, terminator: " ") }
            print()
            return
        }
        
        for i in 1...n {
            if !isUsed[i] {
                arr[k] = i
                isUsed[i] = true
                recursion_15649(k: k + 1)
                isUsed[i] = false
            }
        }
    }
}
