//
//  MergeSort.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 7/24/24.
//  Merge Sort

func sort() {
    var arr = [1, 4, 3, 2, 6, 7]
    let n = arr.count
    
    var tmp: [Int] = .init(repeating: 0, count: n)
    
    mertSort(st: 0, en: n)
    
    for i in arr {
        print(i)
    }
    
    // arr 배열을 st ~ en - 1까지 정렬
    // 두 배열로 나눠서 정렬하기: st~mid & mid~en-1
    func merge(st: Int, en: Int) {
        
        let mid = (st + en) / 2
        
        var lIdx = st
        var rIdx = mid
        
        for i in st..<en {
            if rIdx == en {
                tmp[i] = arr[lIdx]
                lIdx += 1
            } else if lIdx == mid {
                tmp[i] = arr[rIdx]
                rIdx += 1
            } else if arr[lIdx] <= arr[rIdx] {
                tmp[i] = arr[lIdx]
                lIdx += 1
            } else {
                tmp[i] = arr[rIdx]
                rIdx += 1
            }
        }
        for i in st..<en {
            arr[i] = tmp[i]
        }
    }
    
    func mertSort(st: Int, en: Int) {
        if en == st + 1 { return }
        let mid = (st + en) / 2
        
        mertSort(st: st, en: mid)
        mertSort(st: mid, en: en)
        merge(st: st, en: en)
    }
}

