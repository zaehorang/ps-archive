//
//  7569.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 5/5/24.
//  https://www.acmicpc.net/problem/7569

//MARK: 입력 받으면서 익은 토마토 찾기
//MARK: z 축을 따로 고려하는게 아니라 그냥 점 6개를 잡아서 하기
//MARK: BFS가 모든 칸을 방문하는 것은 아님 (아래 예제 참고)

func _7569() {
    let mnh = readLine()!.split(separator: " ").map { Int($0)! }
    let (m, n, h) = (mnh[0], mnh[1], mnh[2])
    var table: [[[Int]]] = .init(repeating: [[Int]](), count: h)
    
    var queue = Queue<[Int]>()
    
    let dz = [0, 0, 0, 0, -1, 1]
    let dx = [-1, 0, 1, 0, 0, 0]
    let dy = [0, 1, 0, -1, 0, 0]
    
    // Input
    for z in 0..<h {
        for x in 0..<n {
            table[z].append(readLine()!.split(separator: " ").map { Int($0)! })
            for y in 0..<m {  // 익은 토마토 찾기
                if table[z][x][y] == 1 {
                    queue.enqueue([z, x, y])
                }
            }
        }
    }
        
    var ans = 0
    
    // BFS
    while !queue.isEmpty {
        guard let prev = queue.dequeue() else { break }
        let z = prev[0]
        let x = prev[1]
        let y = prev[2]
        
        // z, x, y BFS
        for i in 0..<6 {
            let nX = x + dx[i]
            let nY = y + dy[i]
            let nZ = z + dz[i]
            
            // x, y 범위 조건
            if nX < 0 || nY < 0 || nX >= n || nY >= m || nZ < 0 || nZ >= h { continue }
            
            // 중복 체크, 토마토 유무 체크
            if table[nZ][nX][nY] == -1 || table[nZ][nX][nY] > 0 { continue }
            
            table[nZ][nX][nY] = table[z][x][y] + 1
            
            queue.enqueue([nZ, nX, nY])
            
            ans = table[nZ][nX][nY]
        }
    }
    
    for z in 0..<h {
        for x in 0..<n {
            for y in 0..<m {
                if table[z][x][y] == 0 {
                    ans = -1
                    break
                }
                
            }
        }
        
    }
    
    ans <= 0 ? print(ans) : print(ans - 1)

}


/*
 2 2 3
 -1 -1
 -1 -1
 1 -1
 0 0
 -1 0
 -1 0

 4
 
 */
// 모든 칸을 방문하지 않는 일도 발생한다.
// [0, 0, 1]은 방문하지 않는다.


// (+) 다 익은 토마토를 줄 때도 고려하쎄용
//  ans <= 0 ? print(ans) : print(ans - 1)
