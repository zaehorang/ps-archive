//
//  1157.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 1/6/26.
//  https://www.acmicpc.net/problem/1157

import Foundation

func _1157() {
    let str = readLine()!.uppercased()
    var dic: [Character: Int] = [:]
    
    str.forEach {
        dic[$0, default: 0] += 1
    }
    
    let sortedDic = dic.sorted { $0.value > $1.value }
    
    if sortedDic.count == 1 {
        print(sortedDic[0].key)
        return
    }
    
    if sortedDic[0].value != sortedDic[1].value {
        print(sortedDic[0].key)
    } else {
        print("?")
    }
}
