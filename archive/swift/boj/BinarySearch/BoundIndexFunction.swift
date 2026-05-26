//
//  BoundIndexFunction.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 4/7/25.
//

import Foundation

// n이 배열에 놓일 수 있는 최소 인덱스 값을 리턴
func lowerBoundIndex(_ target: Int, arr: [Int]) -> Int {
    var st = 0
    var en = arr.count
    
    while st < en {
      let mid = (st + en) / 2
        
        if arr[mid] >= target {
            // n이 배열에 없는 경우 n보다 큰 숫자가 처음 등장하는 곳이 찾는 인덱스 일 수도 있기 때문에 mid를 할당
            en = mid
        } else {
            st = mid + 1
        }
    }
    return st
}

// n이 배열에 놓일 수 있는 최대 인덱스 값을 리턴
func upperBoundIndex(_ target: Int, arr: [Int]) -> Int {
    var st = 0
    var en = arr.count
    
    while st < en {
        let mid = (st + en) / 2
        
        if arr[mid] > target {
            en = mid
        } else {
            st = mid + 1
        }
    }
    return st
}
