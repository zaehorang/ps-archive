//
//  21940.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 1/8/26.
//  https://www.acmicpc.net/problem/21940

import Foundation

func _21940() {
    let NM = readLine()!.split(separator: " ").compactMap { Int($0)! }
    let (N, M) = (NM[0], NM[1])
    
    let INF = Int.max / 2
    
    var graph: [[Int]] = .init(repeating: .init(repeating: INF, count: N + 1), count: N + 1)
    
    for _ in 0..<M {
        let abt = readLine()!.split(separator: " ").compactMap { Int($0)! }
        let (a, b ,t) = (abt[0], abt[1], abt[2])
        
        graph[a][b] = t
    }
    
    for i in 1...N { graph[i][i] = 0 }
    
    for k in 1...N {
        for i in 1...N {
            for j in 1...N {
                let new = graph[i][k] + graph[k][j]
                if graph[i][j] > new { graph[i][j] = new }
            }
        }
    }
    
    let _ = readLine()
    let targetCitys = readLine()!.split(separator: " ").compactMap { Int($0)! }
    
   var maxCosts = [0]
    for i in 1...N {
        var maxCost = Int.min
        for city in targetCitys {
            let cost = graph[city][i] + graph[i][city]
            maxCost = max(maxCost, cost)
        }
        maxCosts.append(maxCost)
    }
    
    var ans = ""
    
    let sortedX = maxCosts.enumerated().sorted { $0.1 < $1.1 }
    
    let firstX = sortedX[1].0
    let firstCost = sortedX[1].1
    
    ans += "\(firstX) "
    
    for (i, c) in sortedX[2...] {
        
        if firstCost == c {
            ans += "\(i) "
        } else {
            break
        }
    }
    print(ans)
}

func _21940_opt() {
    let NM = readLine()!.split(separator: " ").compactMap { Int($0)! }
    let (N, M) = (NM[0], NM[1])
    
    let INF = Int.max / 2
    
    var graph: [[Int]] = .init(repeating: .init(repeating: INF, count: N + 1), count: N + 1)
    
    for _ in 0..<M {
        let abt = readLine()!.split(separator: " ").compactMap { Int($0)! }
        let (a, b ,t) = (abt[0], abt[1], abt[2])
        
        graph[a][b] = t
    }
    
    for i in 1...N { graph[i][i] = 0 }
    
    for k in 1...N {
        for i in 1...N {
            for j in 1...N {
                let new = graph[i][k] + graph[k][j]
                if graph[i][j] > new { graph[i][j] = new }
            }
        }
    }
    
    let _ = readLine()
    let targetCitys = readLine()!.split(separator: " ").compactMap { Int($0)! }
    
    // MARK: - 최대값들 중에 최소 뽑기
    // 구현 흐름 !
    // 핵심은 이 로직이 “현재까지 본 후보들 중 최적해(best)” 를 계속 유지하는 running minimum 패턴이라는 점
    var bestCost = INF
    var bestCities: [Int] = []
    
    for i in 1...N {
        var worstRoundTrip = 0
        
        for city in targetCitys {
            let go = graph[city][i]
            let back = graph[i][city]
            
            if go >= INF || back >= INF {
                worstRoundTrip = INF
                break
            }
            
            worstRoundTrip = max(worstRoundTrip, go + back)
        }
        
        if worstRoundTrip < bestCost {
            bestCost = worstRoundTrip
            bestCities = [i]
        } else if worstRoundTrip == bestCost {
            bestCities.append(i)
        }
    }
    print(bestCities.map(String.init).joined(separator: " "))
}
