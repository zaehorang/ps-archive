//
//  11403.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 11/5/25.
//

import Foundation


/*
 bfs, dfs 작성할 때 visted나 값 input 시점에 따라서 결과가
 다르게 나오니까 주의
 */

func _11403() {
    let n = Int(readLine()!)!
    
    // make graph
    var graph: [[Int]] = []
    
    for _ in 0..<n {
        let row = readLine()!.split(separator: " ").map { Int($0)! }
        graph.append(row)
    }
    
    var ans: [[Int]] = .init(repeating: .init(repeating: 0, count: n), count: n)
    
    for i in 0..<n {
        var isVisted: [Bool] = .init(repeating: false, count: n)
        
        func dfs(_ current: Int, pastRoute: [Int]) {
            guard !isVisted[current] else {
                // 시작점은 거리가 0이기 때문에 다른 곳에 갔다가 와야지 1 표시
                // 결과를 언제 넣는지에 따라서 분기 처리 안해도 될 듯.
                if current == i {
                    ans[current][current] = 1
                }
                return
            }
            
            isVisted[current] = true
            
            for past in pastRoute {
                ans[past][current] = 1
            }
            
            for k in 0..<n {
                let next = graph[current][k]
                
                if next == 1 {
                    dfs(k, pastRoute: pastRoute + [current])
                }
            }
        }
        
        dfs(i, pastRoute: [])
    }
    
    ans.forEach {
        print($0.map{ String($0) }.joined(separator: " "))
    }
}

func _11403_bfs() {
    let n = Int(readLine()!)!
    
    // make graph
    var graph: [[Int]] = []
    
    for _ in 0..<n {
        let row = readLine()!.split(separator: " ").map { Int($0)! }
        graph.append(row)
    }
    
    var ans: [[Int]] = .init(repeating: .init(repeating: 0, count: n), count: n)
    
    for start in 0..<n {
        var visited = [Bool](repeating: false, count: n)
        // queue에 처음 값을 넣을 때 visted 표시를 안해서 마지막까지 출력 되는 듯
        var queue = [start]
        
        while !queue.isEmpty {
            let top = queue.removeFirst()
            
            for next in 0..<n {
                if graph[top][next] == 1 && !visited[next] {
                    visited[next] = true
                    ans[start][next] = 1
                    queue.append(next)
                }
            }
        }
    }
    
    ans.forEach {
        print($0.map{ String($0) }.joined(separator: " "))
    }
}
