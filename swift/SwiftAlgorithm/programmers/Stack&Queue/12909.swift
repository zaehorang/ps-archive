//
//  12909.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 10/13/24.
//

func solution_12909(_ s:String) -> Bool {
 
    var stack = [Character]()
    
    for char in s {
        if char == "(" {
            stack.append(char)
        } else {
            guard stack.popLast() != nil else { return false }
        }
    }
    if stack.isEmpty {
        return true
    } else {
        return false
    }
}
