//
//  11724.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 10/24/25.
//

func _11724() {
    let NM = readLine()!.split(separator: " ").map { Int($0)! }
    let (N, M) = (NM[0], NM[1])
    
    var tree: [[Int]] = .init(repeating: [], count: N + 1)
    
    // Make tree
    for _ in 0..<M {
        let ab = readLine()!.split(separator: " ").map { Int($0)! }
        let (a, b) = (ab[0], ab[1])
        
        tree[a].append(b)
        tree[b].append(a)
    }
    
    
    func bfs() -> Int {
        var ans = 0
        
        var queue = [Int]()
        var isVisted: [Bool] = .init(repeating: false, count: N + 1)
        
        for i in 1...N {
            if isVisted[i] { continue }
            
            queue.append(i)
            isVisted[i] = true
            ans += 1
            
            while !queue.isEmpty {
                let first = queue.removeFirst()
                
                for val in tree[first] {
                    if isVisted[val] { continue }
                    
                    queue.append(val)
                    isVisted[val] = true
                }
            }
        }
        return ans
    }
    

    func dfs() -> Int {
        var isVisted: [Bool] = .init(repeating: false, count: N + 1)
        var ans = 0
        
        func recursion(_ current: Int) {
            isVisted[current] = true
            
            for i in tree[current] {
                if isVisted[i] { continue }
                recursion(i)
            }
        }
        
        for i in 1...N {
            if isVisted[i] { continue }
            
            ans += 1
            recursion(i)
        }

        return ans
    }

    print(bfs())
    print(dfs())
}
