//
//  7562.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 5/5/24.
//  https://www.acmicpc.net/problem/7562

func _7562() {
    
    let t = Int(readLine()!)!
    
    let dx = [-2, -1, 1, 2, 2, 1, -1, -2]
    let dy = [1, 2, 2, 1, -1, -2, -2, -1]
    
    for _ in 0..<t {
        let i = Int(readLine()!)!
        
        let start = readLine()!.split(separator: " ").map { Int($0)! }
        let destination = readLine()!.split(separator: " ").map { Int($0)! }
        
        if start == destination {
            print(0)
            continue
        }
        
        var queue = Queue<[Int]>()
        
        var table: [[Int]] = .init(repeating: .init(repeating: -1, count: i), count: i)
       
        table[start[0]][start[1]] = 0
        queue.enqueue(start)
        
        while !queue.isEmpty {
            guard let a = queue.dequeue() else { break }
            
            let (x, y) = (a[0], a[1])
            
            for j in 0..<8 {
                
                let nX = x + dx[j]
                let nY = y + dy[j]
                
                if nX < 0 || nY < 0 || nX >= i || nY >= i { continue }
                if table[nX][nY] >= 0 { continue }
                
                table[nX][nY] = table[x][y] + 1
                queue.enqueue([nX, nY])

                if [nX, nY] == destination {  // 목적지에 도착하면
                    print("\(table[nX][nY])")
                    queue.removeAll()
                    break
                }
                
            }
        }
    }
}

