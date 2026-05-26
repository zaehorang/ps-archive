//
//  42578.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 10/11/24.
//

import Foundation

// 🐯
func solution_42578(_ clothes:[[String]]) -> Int {
    var dic = [String: [String]]()
    
    for cloth in clothes {
        let (_, key) = (cloth[0], cloth[1])
        dic[key] = []
    }
    
    for cloth in clothes {
        let (val, key) = (cloth[0], cloth[1])
        dic[key]?.append(val)
    }
    
    var ans = 1
    
    for arr in dic.values {
        ans *= (arr.count + 1)
    }

    return ans - 1
}

// refactor
// 1. String 타입으로 val을 모두 저장하지 않고, Int 타입으로 밑에 추가한 로직을 바로 짤 수 있을 듯
func solution1_42578(_ clothes:[[String]]) -> Int {
    var dic = [String: [String]]()
    
    for cloth in clothes {
        let (val, key) = (cloth[0], cloth[1])
        
        if dic[key] != nil {
            dic[key]?.append(val)
        } else {
            dic[key] = [val]
        }
    }
    
    
    var ans = 1
    
    for arr in dic.values {
        ans *= (arr.count + 1)
    }

    return ans - 1
}

// 다른 살마 풀이 참고
// Set를 사용해서 categories를 분리
func solution2_42578(_ clothes:[[String]]) -> Int {
    let types = clothes.compactMap { $0.last }
    
    let categories = Set(types)
    
    let counts = categories.map { category in
        return clothes.filter { $0.last == category }.count + 1
    }
    
    return counts.reduce(1, { $0 * $1}) - 1
}
