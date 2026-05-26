//
//  120923.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 3/16/25.
//

import Foundation

func solution_120923(_ num:Int, _ total:Int) -> [Int] {
    let mid = total / num
    
    var ans = [mid]
    
    let sideCount = num / 2
    
    for i in 1..<num {
        if i <= sideCount {
            ans.append(ans.last! + 1)
        } else {
            ans.insert(ans.first! - 1, at: 0)
        }
    }
    return ans
}

// n이 충분히 작기 때문에 오래 걸려도 된다.
func solution2_120923(_ num:Int, _ total:Int) -> [Int] {
    var ans: [Int] = []
    
    for i in -1000...1000 {
        if ans.count < num {
            ans.append(i)
        }
        
        
        if ans.reduce(0, +) == total {
            break
        } else {
            ans.removeFirst()
            ans.append(i)
        }
    }
    return ans
}

func solution3_120923(_ num:Int, _ total:Int) -> [Int] {
    // 등차수열 합 공식에서 초항을 a라고 두고 식풀이
    // 마지막 항 = a + num - 1
    let a = (2 * total/num - num + 1) / 2
    return (0..<num).map { a + $0 }
}
