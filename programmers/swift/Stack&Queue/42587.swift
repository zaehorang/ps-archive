//
//  42587.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 10/16/24.
//

import Foundation

func solution_42587(_ priorities:[Int], _ location:Int) -> Int {
    let sortedP = priorities.sorted(by: >)
    var maxIndex = 0
    
    var l = location
    var p = priorities
    
    var ans = 0
    
    func calLocation(_ n: Int) -> Int {
        let newL = l - 1
        if newL < 0 {
           return (p.count - 1)
        } else {
            return newL
        }
    }
    
    while maxIndex != sortedP.count {
        let max = sortedP[maxIndex]
        
       if p[0] == max {
           if l == 0 {
               if ans != 0 {
                   return ans + 1
               } else { return 1 }
           } else {
               p.removeFirst()
               
               ans += 1
               maxIndex += 1
               
              l = calLocation(l)
           }
       } else {
           let a = p.removeFirst()
           p.append(a)

           l = calLocation(l)
       }
    }
    return 0
}


// 내가 처음 풀고 싶었던 방식
// enumerated를 이용하고 싶었는데..
func solution1_42587(_ priorities:[Int], _ location:Int) -> Int {
    var p = priorities.enumerated().map { ($0.offset, $0.element) }
    
    while true {
        let val = p.removeFirst()
        
//        if !p.filter({ val.1 < $0.1 }).isEmpty { // 첫 번째 값보다 큰 값들이 있으면
//            p.append(val)
//        } else {
//            if location == val.0 {
//                return priorities.count - p.count
//            }
//        }
        
        
        // 🐯 아래가 더 빠를 줄 알았는데 filter와 contains는 둘 다 O(n)
        // contains가 조건에 만족하는 상황이 생기고 바로 반복을 종료한다면 약간 더 빠를지도..?
        // 두 개를 비교해보니 Contains가 더 빠르긴 함 (위에 말이 맞을지도..?)
        if p.contains(where: { val.1 < $0.1 }) { // 첫 번째 값보다 큰 값들이 있으면
            p.append(val)
        } else {
            if location == val.0 {
                return priorities.count - p.count
            }
        }
    }
}
