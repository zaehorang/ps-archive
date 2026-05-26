//
//  re_1926.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 9/9/25.
//

import Foundation

func re_1926() {
    let nm = readLine()!.split(separator: " ").map { Int($0)! }
    let (n, m) = (nm[0], nm[1])
    
    var arr: [[Int]] = []
    
    for _ in 0..<n {
        let line = readLine()!
            .split(separator: " ")
            .map { Int($0)! }
        arr.append(line)
    }
    
    
    // 상우하좌
    let dx = [-1, 0, 1, 0]
    let dy = [0, 1, 0, -1]
    
    var visit: [[Bool]] = .init(repeating: .init(repeating: false, count: m), count: n)
 
    var q = [[Int]]()
    
    var maxArea = 0
    var total = 0
    var count = 0
    
    for x in 0..<n {
        for y in 0..<m where visit[x][y] == false && arr[x][y] == 1 {
            q.append([x, y])
            visit[x][y] = true
            total += 1
            
            while !q.isEmpty {
                let pop = q.removeFirst()
                
                for k in 0..<4 {
                    let nX = dx[k] +  pop[0]
                    let nY = dy[k] + pop[1]
                    
                    if nX < 0 || nX >= n || nY < 0 || nY >= m { continue }
                    if arr[nX][nY] == 0 || visit[nX][nY] == true { continue }
                    
                    q.append([nX, nY])
                    visit[nX][nY] = true
                    total += 1
                }
            }
            count += 1
            maxArea = max(maxArea, total)
            total = 0
        }
    }
    print(count)
    print(maxArea)
}
