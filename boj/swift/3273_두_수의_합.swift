//
//  main.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 4/2/24.
//  https://www.acmicpc.net/problem/3273

//MARK: - input
let n = Int(readLine()!)!
let arr = readLine()!.split(separator: " ").map { Int($0)! }
let t = Int(readLine()!)!

//MARK: - solve 1

var s = Array(repeating: 0, count: 2000001)  // count 범위 주의
var ans = 0

for a in arr {
    
    if t - a > 0 && s[t - a] == 1 {  // 인덱스 범위 주의
        ans += 1
    }
    else {
        s[a] = 1
    }
}

//MARK: - solve 2
// O(n^2)은 시간 초과
/*
var i = 1
var ans = 0

for a in arr {
    for idx in i ..< n {
        if a + arr[idx] == t {
            ans += 1
        }
    }
    i += 1
}
*/

//MARK: - with Yu:D
/*
let n = Int(readLine()!)!
let arr = readLine()!.split(separator: " ").map { Int($0)! }
let t = Int(readLine()!)!

// 배열의 최대 값
let max = arr.max()!

var c = Array(repeating: 0, count: arr.max()! + 1)

// 배열에 숫자 체크
for a in arr {
    c[a] = 1
}

//print(c)

var cnt = 0

for a in arr {
    let i = t - a
    
    if i != a && i > 0 && i <= max && c[i] == 1 {
        cnt += 1
        c[a] = 0 // 중복 제거
    }
//
//    print(a)
//    print(cnt)
}

print(cnt)
*/

//MARK: - output
print(ans)
