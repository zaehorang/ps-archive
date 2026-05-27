//
//  42840.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 9/17/25.
//

import Foundation

func _42840(_ answers:[Int]) -> [Int] {
    let first = [1, 2, 3, 4, 5]
    let second = [2, 1, 2, 3, 2, 4, 2, 5]
    let third = [3, 3, 1, 1, 2, 2, 4, 4, 5, 5]
    
    var ans = [Int]()
    var countArr = [0, 0, 0]
    
    (0..<answers.count).forEach {
        if answers[$0] == first[$0 % first.count] { countArr[0] += 1 }
        if answers[$0] == second[$0 % second.count] { countArr[1] += 1 }
        if answers[$0] == third[$0 % third.count] { countArr[2] += 1 }
    }
    
    let m = countArr.max()
    
    countArr.enumerated().forEach {
        if $0.1 == m { ans.append($0.0 + 1) }
    }
    
    return ans
}
