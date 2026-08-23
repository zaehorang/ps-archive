//
//  1012.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 5/2/24.
//  https://www.acmicpc.net/problem/1012

func _1012() {
    
    let t = Int(readLine()!)!
    
    let dx = [-1, 0, 1, 0]
    let dy = [0, 1, 0, -1]
    
    // 테스트 케이스
    for _ in 0..<t {
        
        let mnk = readLine()!.split(separator: " ").map { Int($0)! }
        
        // 가로, 세로, 배추 수
        let (m, n, k) = (mnk[0], mnk[1], mnk[2])
        
        var table: [[Int]] = .init(repeating: .init(repeating: 0, count: n), count: m)
        
        // 배추 표시
        for _ in 0..<k {
            let xy = readLine()!.split(separator: " ").map { Int($0)! }
            let (x, y) = (xy[0], xy[1])
            
            table[x][y] = 1
        }
        
        // bfs 시작
        var queue = Queue<[Int]>()
        
        var ans = 0
        
        for a in 0..<m {
            
            for b in 0..<n {
                
                if table[a][b] == 1 {
                    queue.enqueue([a, b])
                    table[a][b] = 0  // 방문 표시
                    ans += 1
                }
                
                while !queue.isEmpty {
                    
                    guard let xy = queue.dequeue() else { break }
                    
                    for i in 0..<4 {
                        
                        let nX = xy[0] + dx[i]
                        let nY = xy[1] + dy[i]
                        
                        if nX < 0 || nY < 0 || nX >= m || nY >= n { // 인덱스 범위
                            continue
                        }
                        
                        if table[nX][nY] == 0 {
                            continue
                        }
                        
                        queue.enqueue([nX, nY])  // 배추 push
                        table[nX][nY] = 0  // 방문 표시
                        
                    }
                }
            }
        }
        print(ans)
    }
}
