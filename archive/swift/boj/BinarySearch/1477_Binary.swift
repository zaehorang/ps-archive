//
//  1477_Binary.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 5/26/25.
//  휴게소 세우기
//  https://www.acmicpc.net/problem/1477

import Foundation

// Greedy에도 있음
// 잘못된 풀이
func _1477_binary() {
    let nml = readLine()!.split(separator: " ").map { Int($0)! }
    
    let (_, m, l) = (nml[0], nml[1], nml[2])
    
    // 이미 지어진 휴게소 배열
    var arr = [0]
    
    readLine()!.split(separator: " ")
        .forEach { arr.append(Int($0)!) }
    
    arr.sort()
    arr.append(l)
    
    var distance: [Int] = []
    
    for i in 1..<arr.count {
        distance.append(arr[i] - arr[i-1])
    }
    
    distance.sort()
    print("first distance: \(distance)")
    var count = 0
    
    // 휴게소가 다 세워질 때까지 반복
    while count < m {
        
        let last = distance.removeLast()
        let half = last / 2
        
        let secondLast = distance.last!
        
        if half >= secondLast && count + 2 <= m { // 삼등분하기
            let reminder = last % 3
            let val = last / 3
            
            if reminder == 1 {
                distance.append(val)
                distance.append(val)
                distance.append(val + 1)
            } else if reminder == 2 {
                distance.append(val)
                distance.append(val + 1)
                distance.append(val + 1)
            } else {
                distance.append(val)
                distance.append(val)
                distance.append(val)
            }
            
            count += 2
        } else { // 이등분하기
            if last % 2 == 1 {
                distance.append(half)
                distance.append(half + 1)
            } else {
                distance.append(half)
                distance.append(half)
            }
            
            count += 1
        }
        distance.sort()
        print(distance)
    }
    print(distance.last!)
    print("last distance: \(distance)")
}

// 아직 범위 잡는게 어려움 🥲
func _1477_binarySearch() {
    let nml = readLine()!.split(separator: " ").map { Int($0)! }
    
    let (_, m, l) = (nml[0], nml[1], nml[2])
    
    // 휴게소 세팅
    var arr = [0]
    
    readLine()!
        .split(separator: " ")
        .forEach { arr.append(Int($0)!) }
    
    arr.sort()
    arr.append(l)
    
    // Binary Search
    var (st, en) = (1, l)
    
    // 언제 <= 일까? 🥲
    while st < en {
        let mid = (st + en) / 2
        
        var cnt = 0
        
        for i in 1..<arr.count {
            let dist = arr[i] - arr[i-1]
            
            guard dist >= mid else { continue }
            
            if dist % mid != 0 {
                cnt += dist / mid
            } else {
                cnt += (dist / mid) - 1
            }
        }
        
        if cnt > m {
            st = mid + 1
        } else {
            // 언제 -1이 붙을까? 🥲
            en = mid
        }
    }
    print(st)
}
