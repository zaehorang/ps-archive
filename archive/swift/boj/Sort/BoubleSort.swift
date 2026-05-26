//
//  BoubleSort.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 7/19/24.
//

func boubleSort1(arr: inout [Int]) {
    for i in 0..<arr.count {
        for j in 0..<arr.count-1-i {
            if arr[j] > arr[j+1] {
                arr.swapAt(j, j+1)
            }
        }
    }
}

// flag를 추가해서 중간에 정렬이 다 되었으면 반복문 종료시키기
func boubleSort2(arr: inout [Int]) {
    var flag = false
    for i in 0..<arr.count {
        flag = false
        for j in 0..<arr.count-1-i {
            if arr[j] > arr[j+1] {
                arr.swapAt(j, j+1)
                flag = true
            }
        }
        if !flag {
            break
        }
    }
}
