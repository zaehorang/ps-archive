//
//  2562.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 12/23/25.
//

import Foundation

func _2562() {
    var max = 0
    var index = -1
    
    for i in 1...9 {
        let n = Int(readLine()!)!
        if max < n {
            max = n
            index = i
        }
    }
    print(max)
    print(index)
}
