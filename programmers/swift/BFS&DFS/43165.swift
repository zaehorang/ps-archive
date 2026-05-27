//
//  43165.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 9/16/25.
//

import Foundation

/*
 n <= 20
 전체 경우의 수를 구하면 2^n
 
 완전탐색, bfs, dfs 가능
 */

func _43165(_ numbers:[Int], _ target:Int) {
    var dfsCnt = 0
    
    func dfs(index: Int, current: Int) {
        if index == numbers.count - 1 {
            if current == target { dfsCnt += 1 }
            return
        }
        
        dfs(index: index + 1, current: current + numbers[index + 1])
        dfs(index: index + 1, current: current - numbers[index + 1])
    }
    
    func bfs() -> Int {
        var bfsArr = [0]
        
        for n in numbers {
            var newArr = [Int]()
            
            for j in bfsArr {
                newArr.append(j + n)
                newArr.append(j - n)
            }
            bfsArr = newArr
        }
        
        let cnt = bfsArr.reduce(0) {
            $1 == target ? $0 + 1 : $0
        }
        return cnt
    }
    
    dfs(index: -1, current: 0)
    
    print(dfsCnt)
    print(bfs())
}
