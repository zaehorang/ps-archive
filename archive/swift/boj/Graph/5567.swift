//
//  5567.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 10/27/25.
//

import Foundation

func _5567() {
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
    
    
    // bfs
    var isVisted: [Int] = .init(repeating: -1, count: n + 1)
    var queue = [Int]()
    
    queue.append(1)
    isVisted[1] = 0
    
    var ans = 0
    
    while !queue.isEmpty {
        let val = queue.removeFirst()
        let count = isVisted[val]
        
        if count == 2 { break }
        
        for i in tree[val] {
            guard isVisted[i] == -1 else { continue }
            
            isVisted[i] = count + 1
            queue.append(i)
            
            ans += 1
        }
    }
    
    print(ans)
}
