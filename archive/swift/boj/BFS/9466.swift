//
//  9466.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 5/8/24.
//  https://www.acmicpc.net/problem/9466

func _9466() {
    
    let t = Int(readLine()!)!
    
    for _ in 0..<t {
        
        let n = Int(readLine()!)!
        let arr = readLine()!.split(separator: " ").map { Int($0)! }
        
        var queue = Queue<Int>()
        var team = 0
        
        for i in 0..<n {  // 인덱스
            
            queue.enqueue(arr[i])
            var visitedArr: [Int] = .init(repeating: 0, count: n)
            
            while !queue.isEmpty {
                guard let idx =  queue.dequeue() else { break }
                
                if visitedArr[idx - 1] == 1 { // 이전에 방문한 곳이면
                    break
                }
                
                if (i + 1) == arr[idx - 1] {
                    team += 1
                } else {
                    queue.enqueue(arr[idx - 1])
                    visitedArr[idx - 1] = 1 // 방문 표시
                }
                
            }
        }
        
        print(n - team)
    }
    
    
}
