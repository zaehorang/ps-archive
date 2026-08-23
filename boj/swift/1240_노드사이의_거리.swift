//
//  1240.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 11/4/25.
//

import Foundation

/*
 참고:
 distance 때문에 인접 행렬로 그래프/트리를 만들어야 한다고 생각했는데
 tuple을 이용하거나 모델 타입을 하나 만들어서, node와 distance를 쌍으로 갖고 있게 하면
 인접 리스트 형태(나는 배열로 만들긴 함 ^^)로 만들 수 있음
 
 (+) 메모리가 작을 때는 Stack 문제로 dfs보다는 bfs가 더 맞는듯?
 근데 아직 기준은 잘 모르겠다..ㅎ
 */

func _1240() {
    let NM = readLine()!.split(separator: " ").map { Int($0)! }
    
    let (n, m) = (NM[0], NM[1])
    
    var table = [[Int]].init(repeating: .init(repeating: -1, count: n + 1), count: n + 1)
    
    // make tree
    for _ in 1..<n {
        let abc  = readLine()!.split(separator: " ").map { Int($0)! }
        
        let (a, b, distance) = (abc[0], abc[1], abc[2])
        
        table[a][b] = distance
        table[b][a] = distance
    }
    
    var ans = ""
    
    // calculate distance
    for _ in 0..<m {
        let se  = readLine()!.split(separator: " ").map { Int($0)! }
        let (s, e) = (se[0], se[1])
        
        func bfs() {
            var queue: [(Int, Int)] = [(s, 0)]
            var isVisted: [Bool] = .init(repeating: false, count: n + 1)
            isVisted[s] = true
            
            while !queue.isEmpty {
                let (node, distance) = queue.removeFirst()
                
                if  node == e {
                    ans += "\(distance)\n"
                    break
                }
                
                for i in 1...n {
                    guard !isVisted[i] else { continue }
                    guard table[node][i] != -1 else { continue }
                    
                    queue.append((i, distance + table[node][i]))
                    isVisted[i] = true
                }
            }
        }
        
        bfs()
    }
    print(ans)
}


/* 메모리 초과
func _1240() {
    let NM = readLine()!.split(separator: " ").map { Int($0)! }
    
    let (n, m) = (NM[0], NM[1])
    
    var table = [[Int]].init(repeating: .init(repeating: -1, count: n + 1), count: n + 1)
    
    // make tree
    for _ in 1..<n {
        let abc  = readLine()!.split(separator: " ").map { Int($0)! }
        
        let (a, b, distance) = (abc[0], abc[1], abc[2])
        
        table[a][b] = distance
        table[b][a] = distance
    }
    
    var ans = ""
    
    // calculate distance
    for _ in 0..<m {
        let se  = readLine()!.split(separator: " ").map { Int($0)! }
        let (s, e) = (se[0], se[1])
        
        var isFoundAns = false
        
        func dfs(current: Int, target: Int, distance: Int) {
            guard !isFoundAns else { return }
            
            // arrive target
            if current == target {
                ans += "\(distance)\n"
                isFoundAns = true
                return
            }
            
            for i in 1...n {
                guard i != current else { continue }
                guard table[current][i] > -1 else { continue }
                
                dfs(current: i, target: target, distance: distance + table[current][i])
            }
        }
        
        dfs(current: s, target: e, distance: 0)
    }
    print(ans)
}
 */
