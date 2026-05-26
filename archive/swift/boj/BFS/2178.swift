//
//  main.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 4/22/24.
//  https://www.acmicpc.net/problem/2178
import Foundation

func address(of object: UnsafeRawPointer) -> String{
    let address = Int(bitPattern: object)
    return String(format: "%p", address)
}


//MARK: - input
let nm = readLine()!.split(separator: " ").map { Int($0)! }

let (height, width) = (nm[0], nm[1])

var table: [[Int]] = []

for _ in 0 ..< height {
    table.append(readLine()!.map { Int(String($0))! })
}

//MARK: - sovle
// -1로 방문 여부 확인
// (0, 0)에서부터 떨어진 거리를 기록
var distanceTable: [[Int]] = .init(repeating: .init(repeating: 0, count: width), count: height)

var queue = [[0, 0]]
var (x, y) = (0, 0)
var dist = 0

var dx = [-1, 0, 1, 0]
var dy = [0, 1, 0, -1]

//var newX = 0
//var newY = 0

var queueFirst = [0, 0]

table[0][0] = -1
distanceTable[0][0] = 1


while !queue.isEmpty {
    queueFirst  = queue.removeFirst()
    (x, y) = (queueFirst[0], queueFirst[1])
    
    dist = distanceTable[x][y]
    
    
    
    for i in 0..<4 {
        var newX = x + dx[i]
        var newY = y + dy[i]3
        
        if newX < 0 || newX >= height || newY < 0 || newY >= width {
            continue
        }
        
        // 갈 수 있는 거리 or 아직 지나지 않은 거리
        if table[newX][newY] != 1 || table[newX][newY] == -1 {
            continue
        }
        
        
        //MARK: 더 짧은 거리가 마지막 자리를 선점하기 때문에 비교가 필요 없음...
        //        if distanceTable[newX][newY] != 0 {
        //            let len = distanceTable[newX][newY]
        //
        //            distanceTable[newX][newY] = (dist + 1) > len ? len : (dist + 1)
        //            print("dddddr")
        //        } else {
        //            distanceTable[newX][newY] = dist + 1
        //        }
        
        
        distanceTable[newX][newY] = dist + 1
        
        table[newX][newY] = -1
        queue.append([newX, newY])
    }
}

//MARK: - output
print(distanceTable[height-1][width-1])
