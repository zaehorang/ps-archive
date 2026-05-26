//
//  11728.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 7/19/24.
//  배열 합치기
//  Swift 시간초과 이슈 ❌❌❌❌

func _11728_1() {
    let nm = readLine()!.split(separator: " ").map { Int($0)! }
    let (n, m) =  (nm[0], nm[1])
    
    var aCheck: [Bool] = .init(repeating: false, count: n)
    var bCheck: [Bool] = .init(repeating: false, count: m)
    
    
    let a = readLine()!.split(separator: " ").map { Int($0)! }
    let b = readLine()!.split(separator: " ").map { Int($0)! }
    
    var ans: [Int] = []
    
    for i in 0..<n {
        if aCheck[i] { continue }
        for j in 0..<m {
            if bCheck[j] { continue }
            
            let (aN, bN) = (a[i], b[j])
            if aN > bN {
                ans.append(bN)
                bCheck[j] = true
            } else if aN < bN {
                ans.append(aN)
                aCheck[i] = true
                break
            } else {
                ans.append(aN)
                ans.append(bN)
                aCheck[i] = true
                bCheck[j] = true
                break
            }
        }
    }
    
    for i in 0..<n {
        if !aCheck[i] {
            ans.append(a[i])
        }
    }
    
    for i in 0..<m {
        if !bCheck[i] {
            ans.append(b[i])
        }
    }

    for a in ans {
        print(a, terminator: " ")
    }
}


func _11728() {
    let nm = readLine()!.split(separator: " ").map { Int($0)! }
    let (n, m) =  (nm[0], nm[1])
    
    let a = readLine()!.split(separator: " ").map { Int($0)! }
    let b = readLine()!.split(separator: " ").map { Int($0)! }
    
    var ans: [Int] = []
    var (aIdx, bIdx) = (0, 0)
    
    for _ in 0..<n+m {
        if bIdx == m {
            ans.append(a[aIdx])
            aIdx += 1
        } else if aIdx == n {
            ans.append(b[bIdx])
            bIdx += 1
        } else if a[aIdx] >= b[bIdx] {
            ans.append(b[bIdx])
            bIdx += 1
        } else {
            ans.append(a[aIdx])
            aIdx += 1
        }
    }
    
    for num in ans {
        print(num, terminator: " ")
    }
}

