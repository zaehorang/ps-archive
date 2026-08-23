//
//  14499.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 10/23/25.
//

import Foundation

/*
 문제 똑바로 읽기..
 이동한 칸에 쓰여 있는 수가 0이면, 주사위의 바닥면에 쓰여 있는 수가 칸에 복사된다.
 */

/// 주사위 굴리기
func _14499() {
    let nmxyk = readLine()!.split(separator: " ").map { Int($0)! }
    let (n, m, _) = (nmxyk[0], nmxyk[1], nmxyk[4])
    
    var (x, y) = (nmxyk[2], nmxyk[3])
    
    var map: [[Int]] = []
    
    var dice: [Int] = .init(repeating: 0, count: 7)
    
    func chnageDiceForm(_ command: Int) {
        var newDice: [Int] = dice
        if command == 1 { // east
            newDice[4] = dice[1]
            newDice[1] = dice[3]
            newDice[3] = dice[6]
            newDice[6] = dice[4]
            
        } else if command == 2 { // west
            newDice[4] = dice[6]
            newDice[1] = dice[4]
            newDice[3] = dice[1]
            newDice[6] = dice[3]
        } else if command == 3 { // north
            newDice[2] = dice[6]
            newDice[1] = dice[2]
            newDice[5] = dice[1]
            newDice[6] = dice[5]
        } else { // south
            newDice[2] = dice[1]
            newDice[1] = dice[5]
            newDice[5] = dice[6]
            newDice[6] = dice[2]
        }
        
        let mapValue = map[x][y]
        
        if mapValue == 0 {
            map[x][y] = newDice[1]
        } else {
            newDice[1] = mapValue
            map[x][y] = 0
        }
        dice = newDice
    }
    
    func moveDiceInMap(to direction: Int) -> Bool {
        if direction == 1 { // y 판단, 동
            let newY = y + 1
            guard newY < m else { return false}
            
            y = newY
        } else if direction == 2 { // y 판단, 서
            let newY = y - 1
            guard newY >= 0 else { return false}
            
            y = newY
        } else if direction == 3 { // x 판단, 북
            let newX = x - 1
            guard newX >= 0 else { return false}
            
            x = newX
        } else { // x 판단, 남
            let newX = x + 1
            guard newX < n else { return false}
            
            x = newX
        }
        
        return true
    }
    
    for _ in 0..<n {
        let row = readLine()!.split(separator: " ").map { Int($0)! }
        map.append(row)
    }
    
    let commands = readLine()!.split(separator: " ").map { Int($0)! }
    
    for command in commands {
        // 지도에서 갈 수 있는 지 판단
        guard moveDiceInMap(to: command) else { continue }
        
        chnageDiceForm(command)
        
//        printDice(dice)
        print(dice[6])
    }
    
    func printDice(_ a: [Int]) {
        print([" ","\(a[2])"," "])
        print(["\(a[4])","\(a[1])","\(a[3])"])
        print([" ","\(a[5])"," "])
        print([" ","\(a[6])"," "])
    }
}
