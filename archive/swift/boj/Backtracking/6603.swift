//
//  6603.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 11/6/25.
//

import Foundation

func _6603() {
    while true {
        var testCase = readLine()!.split(separator: " ").map { Int($0)! }
        let k = testCase.removeFirst()
        
        guard k != 0 else { return }
        
        let noSelect = k - 6
        
        func recursion(current: Int, ans: [Int], noSelectCount: Int) {
            guard noSelectCount <= noSelect else { return }
            
            guard ans.count < 6 else {
                print(ans.map { String($0) }.joined(separator: " "))
                return
            }
            recursion(current: current + 1, ans: ans + [testCase[current]], noSelectCount: noSelectCount)
            
            recursion(current: current + 1, ans: ans, noSelectCount: noSelectCount + 1)
        }
        
        recursion(current: 0, ans: [], noSelectCount: 0)
        print()
    }
}
