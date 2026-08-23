//
//  1780.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 6/4/24.
//  https://www.acmicpc.net/problem/1780
//  종이의 개수

func _1780() {
    let n = Int(readLine()!)!
    
    var arr: [[Int]] = []
    
    var ans = [0, 0, 0]
    
    for _ in 0..<n {
        arr.append(readLine()!.split(separator: " ").map { Int($0)! })
        
    }
    
    recursion_1780(x: 0, y: 0, n: n)
    
    //MARK: 정답 출력
    for an in ans {
        print(an)
    }
    
    // x, y = 시작점
    // n == 길이
    func recursion_1780(x: Int, y: Int, n: Int) {
        let a = n / 3
        let k = arr[x][y]
        
        // base condition
        // (x,y) 부터 n길이까지 같은 숫자를 갖으면 카운팅해주고 종료
        for i in x..<(x + n) {
            for j in y..<(y + n) {
                
                if k != arr[i][j] {
                    // 같은 숫자를 갖지 못하면 9분면으로 각각 재귀
                    for l in 0..<3 {
                        for c in 0..<3 {
                            recursion_1780(x: x + l * a, y: y + c * a, n: a)
                        }
                    }
                    return
                }
                
            }
        }
        
        // 전체가 같으면
        if k == -1 {
            ans[0] += 1
        } else if k == 0 {
            ans[1] += 1
        } else {
            ans[2] += 1
        }
    }
}

