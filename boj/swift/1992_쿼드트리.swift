//
//  1992.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 6/9/24.
//  https://www.acmicpc.net/problem/1992
//  쿼드트리

func _1992() {
    let n = Int(readLine()!)!
    var table = [[Int]]()
    
    for _ in 0..<n {
        table.append(readLine()!.map { Int(String($0))! })
    }
    
    print(recursion_1992(x: 0, y: 0, len: n))
    
    //MARK: recursion funcion
    func recursion_1992(x: Int, y: Int, len: Int) -> String {
        var ans = "("
        
        if checkSameNumber(a: x, b: y, len: len) {
            return String(table[x][y])
        } else {
            let half = len / 2
            
            ans += recursion_1992(x: x, y: y, len: half)
            ans += recursion_1992(x: x, y: y + half, len: half)
            ans += recursion_1992(x: x + half, y: y, len: half)
            ans += recursion_1992(x: x + half, y: y + half, len: half)
            
            ans += ")"
            
            return ans
        }
    }
    
    func checkSameNumber(a: Int, b: Int, len: Int) -> Bool {
        let first = table[a][b]
        
        for i in a..<(a + len) {
            for j in b..<(b + len) {
                if first != table[i][j] {
                    return false
                }
            }
        }
        return true
    }
}


