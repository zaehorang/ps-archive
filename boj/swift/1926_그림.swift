//
//  main.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 4/22/24.
//  https://www.acmicpc.net/problem/1926

// input
let input = readLine()!.split(separator: " ").map { Int(String($0))! }

// n
let height = input[0]
// m
let width = input[1]

// 그림
var arr: [[Int]] = []

for _ in 0..<height {
    arr.append(readLine()!.split(separator: " ").map({ Int(String($0))! }))
}


// 방문 표시
var vis : [[Bool]] = .init(repeating: .init(repeating: false, count: width), count: height)

// 상,우,하,좌
let dx = [-1, 0, 1, 0]
let dy = [0, 1, 0, -1]

// queue
var q = [[Int]]()

// 탐색 위치 변수
var (max, total, count) = (0, 0, 0)

// count 가 추가되는 조건은 상하좌우가 0이거나 이미 방문한 1일 때
// total 이 추가되는 조건은 방문한 적없는 1일때


for x in 0..<height {
    for y in 0..<width where vis[x][y] == false && arr[x][y] == 1 { // 첫 방문, 색칠된 칸
        q.append([x, y])
        vis[x][y] = true
        total += 1
        
        // 처음 지정된 칸 주위에 색칠되어 있는 칸들은 모두 탐색
        while !q.isEmpty {
            let pop = q.removeFirst()

            // pop된 값 주위 요소 확인 과정
            for k in 0..<4 {
                
                let i = dx[k] + pop.first!
                let j = dy[k] + pop.last!
                
                if i < 0 || i >= height || j < 0 || j >= width { // 범위를 벗어나면
                    continue
                }
                if arr[i][j] == 0 || vis[i][j] == true { // 이미 방문한 곳, 색칠이 안된 곳
                    continue
                }
                
                q.append([i, j])
                total += 1
                vis[i][j] = true
            }
            
            
        }
        
        max = max > total ? max : total
        total = 0
        count += 1
    }
}

print(count)
print(max)
