//
//  1260.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 10/25/25.
//

import Foundation

func _1260() {
    let NMV = readLine()!.split(separator: " ").map { Int($0)! }
    let (N, M, V) = (NMV[0], NMV[1], NMV[2])
    
    // Set로 한 이유는 두 정점 사이에 여러 간선이 있을 수 있기 때문에
    var tree: [Set<Int>] = .init(repeating: .init(), count: N + 1)
    
    for _ in 1...M {
        let ab = readLine()!.split(separator: " ").map { Int($0)! }
        let (a, b) = (ab[0], ab[1])
        
        tree[a].insert(b)
        tree[b].insert(a)
    }
    
    func bfs(_ current: Int) -> String {
        var ans = ""
        
        var isVisted: [Bool] = .init(repeating: false, count: N + 1)
        
        var queue = [current]
        isVisted[current] = true
        
        while !queue.isEmpty {
            let val = queue.removeFirst()
            ans += "\(val) "
            
            for i in tree[val].sorted() {
                if isVisted[i] { continue }
                
                isVisted[i] = true
                queue.append(i)
            }
        }
        
        return ans
    }
    
    func dfs(_ current: Int) -> String{
        var ans = ""
        var isVisted: [Bool] = .init(repeating: false, count: N + 1)
        
        func recursion(_ val: Int) {
            isVisted[val] = true
            ans += "\(val) "
            
            for i in tree[val].sorted() {
                if isVisted[i] { continue }
            
                recursion(i)
            }
        }
        
        recursion(current)
        
        return ans
    }
    
    print(dfs(V))
    print(bfs(V))
}
