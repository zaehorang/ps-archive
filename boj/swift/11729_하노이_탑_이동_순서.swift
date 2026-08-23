//
//  11729.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 6/4/24.
//  https://www.acmicpc.net/problem/11729
// 하노이 탑 이동 순서


// n-1개의 원판을 기둥 1에서 기둥 2로 옮긴다
// n번 원판을 기둥 1에서 기둥 3으로 옮긴다.
// n-1개의 원판을 기둥 2에서 기둥 3으로 옮긴다.
// -> 원판이 n-1개일 때 옮길 수 있으면 원판이 n개일 때에도 옮길 수 있다.

/*
 base condition
 n = 1일 때 print("\(a) \(b))
 
 재귀 식
 n-1개의 원판을 기둥 a에서 기둥 6-a-b로 옮긴다.
 n번 원판을 기둥 a에서 기둥 b로 옮긴다.
 n-1개의 원판을 기둥 6-a-b에서 기둥 b로 옮긴다.
 */

func recursion_11729(a: Int, b: Int, n: Int) {
    if n == 1 {
        print("\(a) \(b)")
        return
    }
    
    recursion_11729(a: a, b: 6 - a - b, n: n - 1)
    print("\(a) \(b)")
    
    recursion_11729(a: 6 - a - b, b: b, n: n - 1)
    
}

func _11729() {
    let n = Int(readLine()!)!
    print((1<<n) - 1)
    recursion_11729(a: 1, b: 3, n: n)
}


// n개의 탑을 a에서 b로 옮기기
func re_recursion_11729(n: Int, from a: Int, to b: Int) {
    // base condition
    if n == 1 {
        print("\(a) \(b)")
        return
    }
    
    let remainder = 6 - a - b
    
    re_recursion_11729(n: n - 1, from: a, to: remainder)
    
    // n번째 탑 b로 옮기기
    print("\(a) \(b)")
    
    re_recursion_11729(n: n - 1, from: remainder, to: b)
}

func re_11729() {
    let n = Int(readLine()!)!
    
    // 2^n - 1
    print((1<<n) - 1)
    re_recursion_11729(n: n, from: 1, to: 3)
}
