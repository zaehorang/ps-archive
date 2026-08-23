//
//  2884.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 1/1/26.
//

import Foundation

func _2884() {
    let hm = readLine()!.split(separator: " ").compactMap { Int($0) }
    var (h, m) = (hm[0], hm[1])
    
    if m < 45 {
        let remainder = 45 - m
        m = 60 - remainder
        
        if h == 0 {
            h = 23
        } else {
            h -= 1
        }
    } else if m == 45 {
        m = 0
    } else {
        m -= 45
    }
    print("\(h) \(m)")
}

/// OBJ 런타임 에러 발생
func _2884_Calendar() {
    let hm = readLine()!.split(separator: " ").compactMap { Int($0) }
    let h = hm[0], m = hm[1]
    
    let calendar = Calendar(identifier: .gregorian)
    let now = Date()
    
    guard let base = calendar.date(bySettingHour: h, minute: m, second: 0, of: now),
          let newDate = calendar.date(byAdding: .minute, value: -45, to: base)
    else { return }
    
    let newHour = calendar.component(.hour, from: newDate)
    let newMinute = calendar.component(.minute, from: newDate)
    
    print("\(newHour) \(newMinute)")
}
