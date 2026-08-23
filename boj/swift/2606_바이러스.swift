//
//  2606.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 10/27/25.
//

import Foundation

func _2606() {
    let n = Int(readLine()!)!
    let k = Int(readLine()!)!
    
    // make tree
    var tree = [[Int]](repeating: [], count: n + 1)
    
    for _ in 0..<k {
        let ab = readLine()!.split(separator: " ").map { Int($0)! }
        let (a, b) = (ab[0], ab[1])

        tree[a].append(b)
        tree[b].append(a)
    }
    
    var ans = 0
    var isVisted = [Bool](repeating: false, count: n + 1)
    
    func dfs(_ current: Int) {
        isVisted[current] = true
        
        for i in tree[current] {
            guard !isVisted[i] else { continue }
            dfs(i)
            ans += 1
        }
    }
    
    dfs(1)
    
    print(ans)
}
