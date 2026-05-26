//
//  1074.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 6/4/24.
//  https://www.acmicpc.net/problem/1074
//  Z

/*
 base condition
 n = 0일 때 return 0
 
 재귀 식
 (r,c)가 1사분변, 2사분면, 3사분면, 4사분변
 */

func _1074() {
    let nrc = readLine()!.split(separator: " ").map { Int($0)! }
    let (n, r, c) = (nrc[0], nrc[1], nrc[2])
    
    print(recursion_1074(n: n, r: r, c: c))
    
}

func recursion_1074(n: Int, r: Int, c: Int) -> Int {
    if n == 0 { return 0 }
    let half = 1 << (n-1)  // 2^(n-1)
    if r < half && c < half { return recursion_1074(n: n - 1, r: r, c: c) }
    if r < half && c >= half { return recursion_1074(n: n - 1 , r: r, c: c - half) + half * half }
    if r >= half && c < half { return recursion_1074(n: n - 1 , r: r - half, c: c) + 2 * half * half }
    
    return recursion_1074(n: n - 1, r: r - half, c: c - half) + 3 * half * half
    
}

func re_1074() {
    let nrc = readLine()!.split(separator: " ").map { Int($0)! }
    let (n, r, c) = (nrc[0], nrc[1], nrc[2])
    print(re_recursion_1074(n: n, r: r, c: c))
}

func re_recursion_1074(n: Int, r: Int, c: Int) -> Int {
    if n == 0 { return 0 }
    let half = 1 << (n - 1)
    let areaSize = half * half
    if r < half && c < half { return re_recursion_1074(n: n - 1, r: r, c: c)}
    if r < half && c >= half { return areaSize + re_recursion_1074(n: n - 1, r: r, c: c - half)}
    if r >= half && c < half { return 2 * areaSize + re_recursion_1074(n: n - 1, r: r - half, c: c)}
    
    return 3 * areaSize + re_recursion_1074(n: n - 1, r: r - half, c: c - half)
}


