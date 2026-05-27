//
//  42586.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 10/15/24.
//

import Foundation

// 시간 초과 풀이 + 안끝남 이슈
func solution_42586(_ progresses:[Int], _ speeds:[Int]) -> [Int] {
    let count = progresses.count
    
    var startIndex = 0
    var ans = [Int]()
    var newProgresses = progresses
    
    while startIndex < count {
        
        if newProgresses[startIndex] != 100 {
            for i in startIndex..<count {
                newProgresses[i] += speeds[i]
            }
        } else {
            var isFinished = false
            var cnt = 0
            
            for i in startIndex..<count {
                if newProgresses[i] >= 100 && !isFinished {
                    cnt += 1
                } else {
                    isFinished = true
                }
            }
            startIndex += cnt
            ans.append(cnt)
        }
    }
    return ans
}

func solution1_42586(_ progresses:[Int], _ speeds:[Int]) -> [Int] {
    func getData(_ idx: Int) -> Int {
        Int(ceil(Double((100 - progresses[idx])) / Double(speeds[idx])))
    }
    
    var ans = [Int]()
    
    var fistData = getData(0)
    var count = 0
    
    for i in 0..<progresses.count {
        let now = getData(i)
        
        if now <= fistData {
            count += 1
        } else {
            ans.append(count)
            count = 1
            fistData = now
        }
    }
    if count != 0 {
        ans.append(count)
    }
    return ans
}

func solution2_42586(_ progresses:[Int], _ speeds:[Int]) -> [Int] {
    var lastDay = 0
    var ans = [Int]()
    
    for idx in 0..<progresses.count {
        let day = Int(ceil(Double((100 - progresses[idx])) / Double(speeds[idx])))
        
        if day > lastDay {
            ans.append(1)
            lastDay = day
        } else {
            // 인덱스에 직접 접근하는 방식 good❗️
            ans[ans.count - 1] += 1
        }
    }
    return ans
}
