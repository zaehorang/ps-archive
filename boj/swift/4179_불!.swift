//
//  main.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 4/25/24.
//  https://www.acmicpc.net/problem/4179

//MARK: - input

func _4179() {
    let rc = readLine()!.split(separator: " ").map { Int($0)! }
    
    let (r, c) = (rc[0], rc[1])  // 가로, 세로
    
    var table: [[Character]] = []
    
    for _ in 0..<r {
        table.append(Array(readLine()!))
    }
    
    //MARK: - solve
    // 초기에 불과 사람의 위치 변수
    var j = [0, 0]
    var f = [0, 0]
    
    var ans = -1
    
    // bfs 거리 기록
    // ❗️ 가로, 세로 입력 순서 중요...
    // c가 세로 개수, r이 가로 개수
    var fireDistanceTable: [[Int]] = .init(repeating: .init(repeating: -1, count: c), count: r)
    var personDistanceTable: [[Int]] = .init(repeating: .init(repeating: -1, count: c), count: r)

    // queue
    var queue = Queue<[Int]>()

    // 상, 우, 하, 좌
    let dx = [-1, 0, 1, 0]
    let dy = [0, 1, 0, -1]

    
    // J, F 초기 위치 찾기
    for i in 0..<r {
        for k in 0..<c {
            if table[i][k] == "J" {  // 사람
                j = [i, k]
                personDistanceTable[i][k] = 0
            } else if table[i][k] == "F" {  // 불
                f = [i, k]
                queue.enqueue(f)  // ❗️불이 하나가 아닐 수도 있음
                fireDistanceTable[i][k] = 0  // 불 표시
                
            }
        }
    }
    
    // BFS - 불 위치 기록
    while !queue.isEmpty {
        guard let elem = queue.dequeue() else { break }
        let (x, y) = (elem[0], elem[1])
        
        for i in 0..<4 {
            
            let xx = x + dx[i]
            let yy = y + dy[i]
            
            // 인덱스 범위 확인
            if xx < 0 || xx >= r || yy < 0 || yy >= c {
                continue
            }
            
            // 벽, 이전 기록
            if table[xx][yy] == "#" || fireDistanceTable[xx][yy] != -1 {
                continue
            }
            
            fireDistanceTable[xx][yy] = fireDistanceTable[x][y] + 1
            
            queue.enqueue([xx, yy])
        }
    }
    
    // J 위치 기록 시작
    queue.enqueue(j)
    
    while !queue.isEmpty {
        guard let elem = queue.dequeue() else { break }
        let (x, y) = (elem[0], elem[1])
        
        for i in 0..<4 {
            
            let xx = x + dx[i]
            let yy = y + dy[i]
            
            // 탈출 성공
            if xx < 0 || xx >= r || yy < 0 || yy >= c {
                ans = personDistanceTable[x][y] + 1
                queue.removeAll()
                break
            }

            // 벽, ❗️이전 기록
            if table[xx][yy] == "#" || personDistanceTable[xx][yy] != -1 {
                continue
            }

            // 불이 더 빠르면
            if fireDistanceTable[xx][yy] != -1 && fireDistanceTable[xx][yy] <= (personDistanceTable[x][y] + 1) {
                continue
            } else { // 사람이 더 빠르면
                personDistanceTable[xx][yy] = personDistanceTable[x][y] + 1
                queue.enqueue([xx, yy])
            }
        }
    }
    
    if ans != -1 {
        print(ans)
    } else {
        print("IMPOSSIBLE")
    }
    
}

//MARK: - output

/* index out of range
 6 7
 .F.#F.#
 #F#.##.
 ..FF##F
 F....JF
 #....##
 F.#F.#.
 */
