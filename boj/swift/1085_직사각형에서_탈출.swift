//
//  1085.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 12/19/25.
//

import Foundation

func _1085() {
    let arr = readLine()!.split(separator: " ").map { Int($0)! }
    let (x, y, w, h) = (arr[0], arr[1], arr[2], arr[3])
    
    let a = min(w - x, x)
    let b = min(h - y, y)
    
    print(min(a, b))
}
