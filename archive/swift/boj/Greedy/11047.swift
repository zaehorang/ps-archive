//
//  11047.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 3/24/25.
//

import Foundation

func _11047() {
    let nk = readLine()!.split(separator: " ").map { Int($0)! }
    var (n, k) = (nk[0], nk[1])
    
    var arr: [Int] = []
    
    while n > 0 {
        arr.append(Int(readLine()!)!)
        n -= 1
    }
    
    var ans = 0
    
    for coin in arr.reversed() {
        ans += k / coin
        k = k % coin
        
        if k == 0 { break }
    }
    
    print(ans)
}
