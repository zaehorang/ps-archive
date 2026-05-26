//
//  2753.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 12/25/25.
//  https://www.acmicpc.net/problem/2753

import Foundation

func _2753() {
    func checkLeapYear(_ n: Int) -> Bool {
        if n % 4 == 0 {
            if (n % 100 != 0) || (n % 400 == 0) {
                return true
            }
        }
        
        return false
    }
    
    let year = Int(readLine()!)!
    
    checkLeapYear(year) ? print(1) : print(0)
}
