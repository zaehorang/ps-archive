//
//  43162.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 9/16/25.
//

import Foundation

/*
 1 <= n <= 200
 */

/// dfs 풀이
func _43162(_ n:Int, _ computers:[[Int]]) {
    var ans = 0
    
    var isVisted: [Bool] = .init(repeating: false, count: n)
    var stack = [Int]()
    
    for i in 0..<n {
        if isVisted[i] == false {
            stack.append(i)
            isVisted[i] = true
        } else {
            continue
        }
        
        while !stack.isEmpty {
            let com1 = stack.removeLast()
            
            for (com2, isConnect) in computers[com1].enumerated() {
                guard com1 != com2 else { continue }
                
                if isConnect == 1 && isVisted[com2] == false {
                    stack.append(com2)
                    isVisted[com2] = true
                }
            }
        }
        
        ans += 1
    }
    print(ans)
}
