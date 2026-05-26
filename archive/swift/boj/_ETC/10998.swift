//
//  10998.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 12/30/25.
//

import Foundation

func _10998() {
   print(
    readLine()!
        .split(separator: " ")
        .compactMap { Int($0) }
        .reduce(1, *)
   )
}
