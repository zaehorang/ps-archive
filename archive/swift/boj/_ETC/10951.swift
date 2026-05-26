//
//  10951.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 12/28/25.
//  https://www.acmicpc.net/problem/10951

import Foundation

/*
 control + D 를 통해 EOF(End Of File)을 보낼 수 있음 (macOS 터미널 기준)
 - EOF를 통해서 값을 받으면 readLine()은 nil 처리가 되고 옵셔널 바인딩에서 while문 종료
 */
func _10951() {
    
    while let text = readLine() {
        print(
            text
                .split(separator: " ")
                .compactMap { Int($0) }
                .reduce(0, +)
        )
    }
}
