//
//  re_12909.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 3/4/25.
//

import Foundation

func reSolution_12909(_ s:String) -> Bool {
    var arr: [Character] = []
    
    for char in s {
        if char == "(" {
            arr.append(char)
        } else { // ")"
            if arr.last == "(" {
                arr.removeLast()
            } else {
                return false
            }
        }
    }
    return arr.isEmpty ? true : false
}
