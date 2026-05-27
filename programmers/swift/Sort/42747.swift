//
//  42747.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 10/8/24.
//  H-Index
//  https://school.programmers.co.kr/learn/courses/30/lessons/42747

// 🐯 혼자 복잡하게 풀었네 ㅎㅎㅎ;;
func solution_42747(_ citations:[Int]) -> Int {
    let max = citations.max()!
    let sortedCitations = citations.sorted(by: >)
    
    for h in (0...max).reversed() {
        var cnt = 0
        for value in sortedCitations {
            if value >= h {
                cnt += 1
                if cnt >= h { return h }
            } else {
                break
            }
        }
    }
    return 0
}

// 풀이 참고
func solution1_42747(_ citations:[Int]) -> Int {
    for (index, value) in citations.sorted(by: >).enumerated() {
        if index >= value { return index }
    }
    
    return citations.count
}

/*
 [1,10,11] return 2
 [10,11] return 2
 [0,0,0,0,0] return 0
 */
