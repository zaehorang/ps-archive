//
//  SelectionSort.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 9/3/24.
//

func selectionSort(arr: inout [Int]) {
    for i in 0..<(arr.count - 1) {  // 왜 -1이 들어가는지 고민해보기
        var minIdx = 0
        for idx in (i + 1)..<arr.count {
            if arr[minIdx] > arr[idx] {
                minIdx = idx
            }
        }
        arr.swapAt(i, minIdx)
    }
}
