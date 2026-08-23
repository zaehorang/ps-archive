//
//  15650.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 7/1/24.
//  https://www.acmicpc.net/problem/15650
//  N과 M (2)

// 🐯 오름차순 문제이기 때문에 for문을 이전 인덱스보다 하나 앞서게 트래킹하면 된다.
func _15650() {
    let nm = readLine()!.split(separator: " ").map { Int($0)! }
    let (n, m) = (nm[0], nm[1])
    
    var arr: [Int] = .init(repeating: 0, count: m)
    var isUsed: [Bool] = .init(repeating: false, count: n + 1)
    
    recursion(k: 0, start: 1)
    
    func recursion(k: Int, start: Int) {
        
        if k == m {
            arr.forEach {
                print($0, terminator: " ")
            }
            print()
            return
        }
        
        // 해당 분기가 프린트 분기 아래에 있어야 한다.
//        if start > n {
//            return
//        }
        // ❗️❗️❗️❗️start..<n + 1
        print("\(start) & \(n)")
        for i in start...n {
            if !isUsed[i] {
                arr[k] = i
                isUsed[i] = true
                recursion(k: k + 1, start: i + 1)
                isUsed[i] = false
            }
        }
    }
    
}
