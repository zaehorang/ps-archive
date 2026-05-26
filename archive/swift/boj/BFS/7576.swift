//
//  main.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 4/22/24.
//  https://www.acmicpc.net/problem/7576

//MARK: - input
let mn = readLine()!.split(separator: " ").map { Int($0)! }

let width = mn[0]
let height = mn[1]

var table: [[Int]] = []

for _ in 0..<height {
    let line = readLine()!.split(separator: " ").map { Int($0)! }
    table.append(line)
}

//MARK: - solve

struct Queue {
    private var datas: [[Int]?] = []
    
    private var head: Int = 0
    
    
    var isEmpty: Bool {
        datas.isEmpty
    }
    
    
    mutating func enqueue(_ elem: [Int]) {
        datas.append(elem)
    }
    
    mutating func dequeue() -> [Int]? {
        guard head < datas.count, let element = datas[head] else { return nil }
        datas[head] = nil
        
        head += 1  // head를 증가시켜 다음 요소로 이동
        
        return element
    }
    
}


var queue = Queue()

var dayTable: [[Int]] = .init(repeating: .init(repeating: 0, count: width), count: height)
var ans = 0

// 처음 주어진 익은 토마토 찾기
for x in 0..<height {
    for y in 0..<width {
        
        if table[x][y] == 1 {  // 익은 토마토 찾기
            queue.enqueue([x, y])
        } else if table[x][y] == 0 {
            dayTable[x][y] = -1
        }
        
    }
}


// BFS
while !queue.isEmpty {
    guard let a = queue.dequeue() else { break }
    
    let (x, y) = (a[0], a[1])
    
    let dx = [-1, 0, 1, 0]
    let dy = [0, 1, 0, -1]
    
    for i in 0..<4{
        
        let newX = x + dx[i]
        let newY = y + dy[i]
        
        // 배열 범위 확인
        if newX < 0 || newX >= height || newY < 0 || newY >= width {
            continue
        }
        
        // 토마토 없으면, 이미 익혔겨나
        if dayTable[newX][newY] >= 0 {
            continue
        }
        
        dayTable[newX][newY] = dayTable[x][y] + 1  // bfs 방문 표시
        ans = dayTable[x][y] + 1
        
        queue.enqueue([newX, newY])
        
    }
    
}

for arr in dayTable {
    if arr.contains(-1) {
        ans = -1
        break
    }
}

print(ans)
