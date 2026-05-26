//
//  1477.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 4/4/25.
//

import Foundation

// ⭐️ 잘못된 그리디 풀이 🥲🥲🥲🥲
func _1477() {
    let nml = readLine()!
        .split(separator: " ")
        .map { Int($0)! }
    
    let (_, m, l) = (nml[0], nml[1], nml[2])
    
    var arr = [l]
    
    readLine()!
        .split(separator: " ")
        .forEach { arr.append(Int($0)!) }
    
    arr.append(0)
    arr.sort(by: <)
    
    var distances = [Int]()
    
    var i = 1
    while i < arr.count {
        distances.append(arr[i] - arr[i - 1])
        i += 1
    }

    distances.sort(by: <)
    
    // 쪼개고, 정렬
    for _ in 0..<m {
        let max = distances.removeLast()
        
        let newDistansce = max / 2
        
        if max % 2 == 1 {
            distances.append(newDistansce)
            distances.append(newDistansce + 1)
        } else {
            distances.append(newDistansce)
            distances.append(newDistansce)
        }
        
        distances.sort(by: <)
    }
    print(distances.last!)
}

// TODO: 일단 포기;;;;;
func _1477_parameterSearch() {
    let nml = readLine()!
        .split(separator: " ")
        .map { Int($0)! }
    
    let (m, l) = (nml[1], nml[2])
    
    var arr = [l]
    
    readLine()!
        .split(separator: " ")
        .forEach { arr.append(Int($0)!) }
    
    arr.append(0)
    arr.sort(by: <)
    
    var distances = [Int]()
    
    var i = 1
    while i < m + 1 {
        distances.append(arr[i] - arr[i - 1])
        i += 1
    }
    
    distances.sort(by: <)
    
    var start = 1
    var end = l - 1
    
    while start <= end {
        let mid = (end + start) / 2
        var ans = 0
        
        for distance in distances {
            let val = distance / mid
            let rest = distance % mid
            
            if rest == 0 {
               ans += (val - 1)
            } else {
                ans += val
            }
        }
        
        // binary search
        if ans > m {
            start = mid + 1
        } else {
            end = mid
        }
    }
    print(start)
}
