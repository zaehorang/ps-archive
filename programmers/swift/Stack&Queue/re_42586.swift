//
//  re_42586.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 3/3/25.
//

import Foundation

func reSolution_42586(_ progresses:[Int], _ speeds:[Int]) -> [Int] {
    var stack = progresses
    var speedStack = speeds
    
    var ans: [Int] = []
    
    while !stack.isEmpty {
        
        for i in stack.indices {
            stack[i] += speedStack[i]
        }
        
        var count = 0
        
        for n in stack {
            if n >= 100 {
                count += 1
                
                // 앞에서부터 지우는 것은 오버헤드 문제 발생
                stack.removeFirst()
                speedStack.removeFirst()
                
                if stack.isEmpty {
                    ans.append(count)
                    break
                }
                
            } else {
                if count > 0 { ans.append(count) }
                break
            }
        }
    }
    return ans
}

func reSolution2_42586(_ progresses:[Int], _ speeds:[Int]) -> [Int] {
    var last = 0
    var ans = [Int]()
    
    for i in progresses.indices {
        let day = Int(ceil(Double(100 - progresses[i]) / Double(speeds[i])))
        
        if day > last { // 같은 경우는 앞에 배포와 같이 되면 되니까 else에서 처리
            ans.append(1)
            last = day
        } else { // last가 더 큰 경우
            ans[ans.count - 1] += 1
        }
    }
    return ans
}
