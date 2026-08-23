//
//  1927.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 10/21/25.
//

import Foundation

func _1927() {
    // Make min heap
    struct MinHeap {
        private var heap = [0]
        private var size = 0
        
        private var areSorted: (Int, Int) -> Bool = {
            $0 <= $1 }
        
        mutating func push(_ n: Int) {
            heap.append(n)
            size += 1
            
            var index = size
            
            while index != 1 {  // ⭐️
                let parentIndex = index / 2
                
                if areSorted(heap[parentIndex], heap[index]) {
                    break
                }
                
                heap.swapAt(parentIndex, index)
                index = parentIndex
            }
        }
        
        mutating func pop() -> Int {
            guard size > 0 else { return 0 }
            
            let min = heap[1]
            heap[1] = heap[size]
            heap.removeLast()
            size -= 1  // ⭐️
            
            var index = 1
            
            while index * 2 <= size {
                let leftChildIndex = index * 2
                let rightChildIndex = index * 2 + 1
                
                var targetIndex = leftChildIndex
                
                if rightChildIndex <= size, areSorted(heap[rightChildIndex], heap[leftChildIndex]) {
                    targetIndex = rightChildIndex
                }
                
                if areSorted(heap[index], heap[targetIndex]) {
                    break
                }
                
                heap.swapAt(targetIndex, index)
                index = targetIndex
            }
            
            return min
        }
        
        
    }
    
    // Start solution
    let n = Int(readLine()!)!
    
    var heap = MinHeap()
    
    for _ in 0..<n {
        let a = Int(readLine()!)!
        
        if a != 0 {
            heap.push(a)
        } else {
            print(heap.pop())
        }
    }
}
