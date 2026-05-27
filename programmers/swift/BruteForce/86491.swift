//
//  86491.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 9/17/25.
//
//

/*
 https://school.programmers.co.kr/learn/courses/30/lessons/86491?language=swift
 
최소직사각형
 */

import Foundation

func _86491(_ sizes:[[Int]]) {
    var w = 0
    var h = 0
    
    sizes.forEach {
        let new = $0.sorted()
        w = max(w, new[0])
        h = max(h, new[1])
    }
    
    print(w * h)
}
