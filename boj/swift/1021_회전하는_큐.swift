//
//  main.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 4/12/24.
//  https://www.acmicpc.net/problem/1021


//MARK: - input
let mn = readLine()!.split(separator: " ").map { Int($0)! }
let m = mn[0]
let n = mn[1]

let nums = readLine()!.split(separator: " ").map { Int($0)!}

//MARK: - solve1 - 오버 헤드 고민 안하고 풀어보기
var arr = Array(1...m)

var ans = 0

for a in nums {
    let count = arr.count
    let frontDistance = arr.firstIndex(of: a)!
    
    let backDistance = count - frontDistance
    
    if frontDistance > backDistance {  // 오른쪽으로 움직이기
        while arr.first != a {
            // 배열 앞에 추가하는 메서드가 없나?
            arr.insert(arr.removeLast(), at: 0)
            ans += 1
        }
        
        arr.removeFirst()
        
    } else { // 왼쪽으로 움직이기
        while arr.first != a {
            arr.append(arr.removeFirst())

            ans += 1
        }
        
        arr.removeFirst()
    }
}


//MARK: - output
print(ans)
