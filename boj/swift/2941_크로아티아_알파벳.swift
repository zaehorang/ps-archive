//
// 2941.swift
// Swift_Algorithm
//
// Created by zaehorang on 2026/2/2.
// https://acmicpc.net/problem/2941
//

import Foundation

func _2941() {
    // Your solution here
    var str = readLine()!
    let replace = ["dz=","c=", "c-", "d-", "lj", "nj", "s=", "z="]
    for e in replace {
        str = str.replacingOccurrences(of: e, with: "a")
    }
    print(str.count)
}

