//
//  5427.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 5/6/24.
//  https://www.acmicpc.net/problem/5427

/*
1
3 3
*.*
.@.
*.*
 
output: 2
answer: IMPOSSIBLE
*/

/*
1
10 5
##########
#@....#*.#
#.....#..#
#.....#..#
##.#######

output: IMPOSSIBLE
answer: 5
*/


func _5427() {
    
    let t = Int(readLine()!)!
    
    let dx = [-1, 0, 1, 0]
    let dy = [0, 1, 0, -1]
    
    for _ in 0..<t {
        
        let wh = readLine()!.split(separator: " ").map { Int($0)! }
        let (w, h) = (wh[0], wh[1])
        
        var distanceTable: [[Int]] = .init(repeating: .init(repeating: -1, count: w), count: h)
        var table: [[Character]] = []
        
        var queue = Queue<[Int]>()
        
        for _ in 0..<h {
            table.append(Array(readLine()!))
        }
        
        var me: [[Int]] = []
        
        // @, * 위치 찾기
        for x in 0..<h {
            for y in 0..<w {
                if table[x][y] == "@" {
                    me.append([x, y])
                } else if table[x][y] == "*" {
                    queue.enqueue([x, y])
                    distanceTable[x][y] = 0
                }
            }
        }
        
        
        // 불 위치
        while !queue.isEmpty {
            guard let f = queue.dequeue() else { break }
            
            let (x, y) = (f[0], f[1])
            
            for i in 0..<4 {
                let (nX, nY) = (x + dx[i], y + dy[i])
                
                if nX < 0 || nY < 0 || nX >= h || nY >= w { continue }
                if distanceTable[nX][nY] >= 0 || table[nX][nY] == "#" { continue }
                
                distanceTable[nX][nY] = distanceTable[x][y] + 1
                queue.enqueue([nX, nY])
                
            }
        }

        // 상근이 위치
        queue.enqueue(me[0])
        distanceTable[me[0][0]][me[0][1]] = 0
        
        var isPossible = false
        
        while !queue.isEmpty {
            guard let m = queue.dequeue() else { break }
            
            let (x, y) = (m[0], m[1])
            let currentDistance = distanceTable[x][y]
            
            for i in 0..<4 {
                let (nX, nY) = (x + dx[i], y + dy[i])
                
                // 탈출 성공
                if nX < 0 || nY < 0 || nX >= h || nY >= w {
                    print(currentDistance + 1)
                    isPossible = true
                    queue.removeAll()
                    break
                }
                
                // 불이 지나가지 않은 길을 갈 때 예외 처리
                if distanceTable[nX][nY] == -1 &&  table[nX][nY] != "#"{
                    distanceTable[nX][nY] = currentDistance + 1
                    queue.enqueue([nX, nY])
                    continue
                }
                
                // 벽 or 불이 먼저 지나감
                if distanceTable[nX][nY] <= (currentDistance + 1) || table[nX][nY] == "#" {
                    continue
                }
                
                distanceTable[nX][nY] = currentDistance + 1
                queue.enqueue([nX, nY])
                
            }
        }

        if !isPossible {
            print("IMPOSSIBLE")
        }
        
    }
    
    
}


