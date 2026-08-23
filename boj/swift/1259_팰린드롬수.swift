//
//  1259.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 12/27/25.
//  https://www.acmicpc.net/problem/1259

import Foundation

func _1259() {
    while true {
        let nString = readLine()!
        
        guard nString != "0" else { return }
        
        let reversedNString = String(nString.reversed())
        
        if nString == reversedNString {
            print("yes")
        } else {
            print("no")
        }
    }
}
