//
//  11780.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 1/5/26.
//  http://acmicpc.net/problem/11780

import Foundation

func _11780() {
    let N = Int(readLine()!)!
    let M = Int(readLine()!)!
    
    let INF = Int.max / 2
    
    var route: [[Int]] = .init(repeating: .init(repeating: INF, count: N + 1), count: N + 1)
    var next: [[Int]] = .init(repeating: .init(repeating: 0, count: N + 1), count: N + 1)
    
    
    for _ in 0..<M {
        let abc = readLine()!.split(separator: " ").compactMap { Int($0) }
        let (a, b, c) = (abc[0], abc[1], abc[2])
        
        route[a][b] = min(route[a][b], c)
        next[a][b] = b
    }
    
    for i in 1...N { route[i][i] = 0 }
    
    for k in 1...N {
        for i in 1...N {
            for j in 1...N {
                let cost = route[i][k] + route[k][j]
                
                if cost < route[i][j] {
                    route[i][j] = cost
                    next[i][j] = next[i][k]
                }
            }
        }
    }
    
    var costAns = ""
    
    for i in 1...N {
        for j in 1...N {
            let cost = route[i][j] < INF ? route[i][j] : 0
            costAns += "\(cost) "
        }
        costAns += "\n"
    }
    
    print(costAns)
    
    func findRoute(_ start: Int, _ end: Int) -> [Int] {
        var ans = [start]
        var nxt = next[start][end]
        
        while nxt != end {
            guard nxt != 0 else { return [0] }
            ans.append(nxt)
            nxt = next[nxt][end]
        }
        
        ans.append(end)
        
        return ans
    }
    
    func findRoute_(_ start: Int, _ end: Int) -> [Int] {
        if route[start][end] == 0 || route[start][end] == INF { return [0] }
        
        var st = start
        var path = [Int]()
        
        while st != end {
            path.append(st)
            st = next[st][end]
        }
        path.append(end)
        return path
    }
    
    for i in 1...N {
        for j in 1...N {
            let r = findRoute_(i, j)
            
            if r[0] == 0 {
                print(0)
                continue
            }
            
            let rs = r.map { String($0) }.joined(separator: " ")
            
            print("\(r.count) \(rs)")
        }
    }
}
