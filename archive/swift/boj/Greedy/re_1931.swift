//
//  re_1931.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 3/30/25.
//  회의실 배정
//  https://www.acmicpc.net/problem/193

func re_1931() {
    let n = Int(readLine()!)!
    var i = 1
    var meetings = [(Int, Int)]()
    
    while i <= n {
        let meeting = readLine()!.split(separator: " ").map { Int($0)! }
        meetings.append((meeting[0], meeting[1]))
        
        i += 1
    }
    
    meetings.sort {
        if $0.1 == $1.1 { return $0.0 < $1.0 }
        return $0.1 < $1.1
    }
    
    var ans = 1
    var start = meetings[0].0
    var last = meetings[0].1
    
    var j = 1
    
    while j < n {
        let nS = meetings[j].0
        let nL = meetings[j].1
        
        if nL >= last && nS >= last {
            ans += 1
            start = nS
            last = nL
        }
        
        j += 1
    }
    print(ans)
}
/*
 4
 2 10
 1 2
 3 4
 4 5
 
 3
 */

/*
 4
 1 1
 1 2
 2 2
 2 3
 
 4
 */
