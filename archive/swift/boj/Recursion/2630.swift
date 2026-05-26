//
//  2630.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 6/7/24.
//  https://www.acmicpc.net/problem/2630
//  색종이 만들기

func _2630() {
    let n = Int(readLine()!)!
    var table = [[Int]]()
    
    for _ in 0..<n {
        table.append(readLine()!.split(separator: " ").map { Int($0)! })
    }
    
    var ans = [0, 0] // 흰, 파
    
    recursion_2630(a: 0, b: 0, n: n)
    
    print(ans[0])
    print(ans[1])
    
    func checkSameColor(a: Int, b: Int, n: Int) -> Bool {
        let first = table[a][b]
        
        // ❗️ 좌표니까 n까지가 아니라 시작점에서 길이를 더해준 곳 까지
        for i in a..<(a + n) {
            for j in b..<(b + n) {
                if first != table[i][j] {
                    return false
                }
            }
        }
        
        return true
    }
    
    func recursion_2630(a: Int, b: Int, n: Int) {
        // base condition
        if checkSameColor(a: a, b: b, n: n) {
            if table[a][b] == 0 {
                ans[0] += 1
            } else {
                ans[1] += 1
            }
            return
        }
        
        let half = n / 2
        
        recursion_2630(a: a, b: b, n: half)
        recursion_2630(a: a + half, b: b, n: half)
        recursion_2630(a: a, b: b + half, n: half)
        recursion_2630(a: a + half, b: b + half, n: half)
    }
    
}

