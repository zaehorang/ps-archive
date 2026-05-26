//
//  1330.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 12/23/25.
//

import Foundation

func _1330() {
    let nums = readLine()!.split(separator: " ")
    let (a, b) = (nums[0], nums[1])
    
    if a > b {
        print(">")
    } else if a < b {
        print("<")
    } else {
        print("==")
    }
}
