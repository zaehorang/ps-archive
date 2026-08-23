//
//  10026.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 5/2/24.
//  https://www.acmicpc.net/problem/10026
// 반례 : https://www.acmicpc.net/board/view/108755

func _10026() {
    let n = Int(readLine()!)!
    
    // 사람에 따라 table 두 개 생성
    var table1: [[Character]] = []
    var table2: [[Character]] = []
    
    for _ in 0..<n {
        let str = readLine()!
        var arr1 = [Character]()
        var arr2 = [Character]()
        
        for char in str {
            arr1.append(char)
            
            if char == "G" {
                arr2.append("R")
            } else {
                arr2.append(char)
            }
            
        }
        
        table1.append(arr1)
        table2.append(arr2)
    }
    
    print(bfs(table1), terminator: " ")
    print(bfs(table2))
    
}


func bfs(_ table: [[Character]]) -> Int{
    let cnt = table.count
    
    var visitedTable: [[Int]] = .init(repeating: .init(repeating: 0, count: table.count), count: table.count)
    var ans = 0
    
    var queue = Queue<[Int]>()
    let dx = [-1, 0, 1, 0]
    let dy = [0, 1, 0, -1]
    
    for x in 0..<cnt {
        
        for y in 0..<cnt {
            
            if visitedTable[x][y] != 1 {
                queue.enqueue([x, y])
                visitedTable[x][y] = 1  // 방문 표시
                ans += 1
                
                while !queue.isEmpty {
                    guard let xy = queue.dequeue() else { break }
                    let (x, y) = (xy[0], xy[1])
                    
                    for i in 0..<4 {
                        let nX = x + dx[i]
                        let nY = y + dy[i]
                        
                        if nX < 0 || nY < 0 || nX >= cnt || nY >= cnt  {  // 인덱스 범위 확인
                            continue
                        }
                        
                        if visitedTable[nX][nY] == 1 {  // 이전에 방문 여부 확인
                            continue
                        }
                        
                        if table[x][y] == table[nX][nY] {  // 색상이 같으면
                            queue.enqueue([nX, nY])
                            visitedTable[nX][nY] = 1  // 방문 표시
                        }
                    }

                }
            }
        }
    }
    return ans
}

/*
 20
 BBBBBRRRRRRRRRRRBBBB
 BBBBBRRRRRRRRRRRBBBB
 RBBBBBRRRRRRRRRRBBBB
 RRRBBBBRRRRRRRRRBBBB
 RRRBBBBRRRRRRRRRRBRB
 GRRBBBBRRRRRRRRRRBRR
 GGRRRRBBBRRRRRRRRBBB
 GGGRRRBBBRRRRRRRRBBB
 RRGGGGBBBRRRRRRRRBBB
 BBGGGGBBBBRRRRRRRBBB
 BBGGGGGBBBRRRRRRRBBB
 GBGGGGGBRRRRRRRRRBBB
 GGGGGGGGRRRRRRRRRBBB
 GGGGGGGGGRRRRRRRRBBB
 GGGGGGGGGGRRRRRRRBBB
 RRGGGGGGGGGGRRRRRRBB
 RRGGGGGGGGGGGGGGGRBB
 RRRGGGGGGGGGGGGGGRBB
 GGGGGGGBGGGGGGGGGGBB
 RRRRGGGGGGGGGGGGGGGG
 
 11 6
 */

/*
 2
 GR
 RG
 2 1
 */
