//
// 15686.swift
// Swift_Algorithm
//
// Created by zaehorang on 2026/4/13.
// https://acmicpc.net/problem/15686
//

import Foundation

func _15686() {
    // Your solution here
    typealias Point = (x: Int, y: Int)
    
    let nm = readLine()!.split(separator: " ").compactMap { Int($0) }
    let (n, m) = (nm[0], nm[1])
    
    var chickens: [Point] = []
    var table: [[Int]] = []
    

    
    for i in 0..<n {
        let row = readLine()!.split(separator: " ").compactMap { Int($0) }
        table.append(row)
        
        for j in 0..<n where row[j] == 2 { chickens.append((i, j)) }
    }
        
    var ans = Int.max
    
    let dx = [0, 0, 1, -1]
    let dy = [1, -1, 0, 0]
    
    func combinations<T>(_ array: [T], _ n: Int) -> [[T]] {
        guard n > 0 else { return [[]] }
        guard let first = array.first else { return [] }
        
        // Recursive case: pick first element + combinations of rest,
        // or skip first element
        let head = [first]
        let subcombinations = combinations(Array(array.dropFirst()), n - 1)
        let ret = subcombinations.map { head + $0 }
        
        return ret + combinations(Array(array.dropFirst()), n)
    }

    // Example usage:
    let result = combinations(chickens, m)
    
    for combination in result {
        var isVisted: [[Int]] = .init(repeating: .init(repeating: -1, count: n), count: n)
        
        var queue = combination
        var head = 0
        
        combination.forEach { isVisted[$0][$1] = 0 }
        
        var count = 0
        
        
        while head < queue.count {
            let (x, y) = queue[head]
            head += 1
            
            for i in 0..<4 {
                let nx = x + dx[i]
                let ny = y + dy[i]
                
                if nx < 0 || nx >= n || ny < 0 || ny >= n {
                    continue
                }
                
                if isVisted[nx][ny] == -1 {
                    isVisted[nx][ny] = isVisted[x][y] + 1
                    queue.append((nx, ny))
                    
                    if table[nx][ny] == 1 { count += isVisted[nx][ny] }
                }
            }
        }
        
        ans = min(ans, count)
    }
    print(ans)
}


func _15686_1() {
    typealias Point = (x: Int, y: Int)

    let nm = readLine()!.split(separator: " ").compactMap { Int($0) }
    let n = nm[0]
    let m = nm[1]

    var houses: [Point] = []
    var chickens: [Point] = []

    for i in 0..<n {
        let row = readLine()!.split(separator: " ").compactMap { Int($0) }
        for j in 0..<n {
            if row[j] == 1 {
                houses.append((i, j))
            } else if row[j] == 2 {
                chickens.append((i, j))
            }
        }
    }

    let houseCount = houses.count
    let chickenCount = chickens.count

    var dist: [[Int]] = .init(
        repeating: .init(repeating: 0, count: chickenCount),
        count: houseCount
    )

    for i in 0..<houseCount {
        for j in 0..<chickenCount {
            dist[i][j] = abs(houses[i].x - chickens[j].x) + abs(houses[i].y - chickens[j].y)
        }
    }

    var selected: [Int] = []
    var answer = Int.max

    func dfs(_ start: Int) {
        if selected.count == m {
            var total = 0

            for i in 0..<houseCount {
                var minDist = Int.max
                for chickenIndex in selected {
                    minDist = min(minDist, dist[i][chickenIndex])
                }
                total += minDist

                if total >= answer { return }
            }

            answer = min(answer, total)
            return
        }

        for i in start..<chickenCount {
            selected.append(i)
            dfs(i + 1)
            selected.removeLast()
        }
    }

    dfs(0)
    print(answer)
}
