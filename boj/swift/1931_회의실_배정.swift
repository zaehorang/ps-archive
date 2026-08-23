//
//  1931.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 5/4/24.
//  https://www.acmicpc.net/problem/1931

// https://please-amend.tistory.com/31#google_vignette

func _1931() {
    
    let n = Int(readLine()!)!
    
    var arr: [[Int]] = []
    
    
    for _ in 0..<n {
        let times = readLine()!.split(separator: " ").map { Int($0)! }
        arr.append(times)
    }
    
    // 시작 시간 오름차순 정렬
    arr.sort { a, b in
        if a[0] != b[0] {
            a[0] <= b[0]
        } else {  //  시작시간 같으면
            a[1] <= b[1]  // 끝나는 시간 오름차순 정렬
        }
    }

    var stack = [arr.removeFirst()]
    
    for next in arr {
        let prev = stack.last!
        
        if next[0] >= prev[1] {  // 현재 회의 이후에 진행되는 회의면
            stack.append(next)
            continue
        }
        
        if next[1] >= prev[1] {  // 다음 회의의 길이가 더 짧으면
            continue
        } else { // next[1] < prev[1]
            stack.removeLast()
            stack.append(next)
        }
    }
    print(stack.count)
}



/*
4
1 4
4 4
4 4
4 5

4
 */
