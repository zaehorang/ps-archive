//
//  10952.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 12/30/25.
//

import Foundation

func _10952() {
    while true {
        let ab = readLine()!
            .split(separator: " ")
            .compactMap { Int($0) }
        if ab[0] == 0 { return }
        print(ab[0] + ab[1])
    }
}
