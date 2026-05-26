//
//  9963.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 7/2/24.
//  https://www.acmicpc.net/problem/9663
//  N-Queen

func _9963() {
    let n = Int(readLine()!)!
    
    var isUsed1: [Bool] = .init(repeating: false, count: n)  // 같은 행 판단
    var isUsed2: [Bool] = .init(repeating: false, count: (n - 1) * 2 + 1)  // 오른 대각 판단
    var isUsed3: [Bool] = .init(repeating: false, count: (n - 1) * 2 + 1)  // 왼 대각 판단
    
    var ans = 0
    
    recursion(k: 0)
    
    // k는 x
    func recursion(k: Int) {
        if k == n {
            ans += 1
            return
        }
        
        // i는 y
        for i in 0..<n {
            if isUsed1[i] || isUsed2[i + k] || isUsed3[k - i + n - 1] {  // 해당 위치에 둘 수 없으면
                continue
            }
            
            isUsed1[i] = true
            isUsed2[i + k] = true
            isUsed3[k - i + n - 1] = true
            
            recursion(k: k + 1)
            
            isUsed1[i] = false
            isUsed2[i + k] = false
            isUsed3[k - i + n - 1] = false
        }
    }
    print(ans)
}
