//
//  2960.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 7/28/25.
//

import Foundation

func _2960() -> Int {
    let NK = readLine()!.split(separator: " ").map { Int($0)! }
    let (N, K) = (NK[0], NK[1])
    
    var table = [Bool](repeating: false, count: N + 1)
    var cnt = K
    
    for i in 2...N {
        guard table[i] == false else { continue }
        table[i] = true
        cnt -= 1
        if cnt == 0 { return i }
        
        for j in i...N {
            let num = i * j
            
            guard num <= N else { break }
            guard table[num] == false else { continue }
            
            table[num] = true
            cnt -= 1
            if cnt == 0 { return num }
        }
    }
    
    return 0
}
