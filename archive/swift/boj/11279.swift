//
// 11279.swift
// Swift_Algorithm
//
// Created by zaehorang on 2026/3/4.
// https://acmicpc.net/problem/11279
//

import Foundation

func _11279() {
    // Your solution here
    struct PriorityMaxQueue {
        private var arr: [Int] = [0]
        private var isEmpty: Bool { arr.count == 1 }
        private var count = 0
        
        mutating func push(_ n: Int) {
            arr.append(n)
            count += 1
            
            var index = count
            
            while index != 1 {
                let parentIdx = index / 2
                if arr[parentIdx] >= arr[index] { break }
                
                arr.swapAt(parentIdx, index)
                index = parentIdx
            }
        }
        
        mutating func pop() -> Int {
            guard count > 0 else { return 0 }
            
            let top = arr[1]
            arr[1] = arr.last!
            arr.removeLast()
            count -= 1
            
            var index = 1
            
            while index * 2 <= count {
                let leftChildIdx = index * 2
                let rightChildIdx = index * 2 + 1
                
                var targetIdx = leftChildIdx
                
                if count >= rightChildIdx,
                   arr[rightChildIdx] > arr[leftChildIdx] {
                    targetIdx = rightChildIdx
                }
                
                if arr[index] >= arr[targetIdx] { break }
                
                arr.swapAt(targetIdx, index)
                index = targetIdx
                
            }

            return top
        }
    }
    
    var pq = PriorityMaxQueue()
    
    let n = Int(readLine()!)!
    
    var ans: [Int] = []
    
    for _ in 0..<n {
        let i = Int(readLine()!)!
        
        if i == 0 {
            ans.append(pq.pop())
        } else {
            pq.push(i)
        }
    }
    
    print(ans.map { String($0) }.joined(separator: "\n"))
}
