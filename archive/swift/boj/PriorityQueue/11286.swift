//
//  11286.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 10/17/25.
//


struct AbsMinHeap {
    var heap: [Int] = [0]
    var size = 0
    
    let areSorted: (Int, Int) -> Bool = {
        if abs($0) == abs($1) {
            return $0 < $1
        } else {
            return abs($0) < abs($1)
        }
    }
    
    mutating func push(_ elem: Int) {
        size += 1
        heap.append(elem)
        
        var index = size
        
        while index != 1 {
            let parentIndex = index / 2
            
            if areSorted(heap[parentIndex], heap[index]) {
                break
            }
            
            heap.swapAt(parentIndex, index)
            index = parentIndex
        }
    }
    
    mutating func pop() -> Int {
        if size == 0 {
          return 0
        }
        
        let min = heap[1]
        
        heap[1] = heap[size]
        size -= 1
        heap.removeLast()
        
        var index = 1
        
        while index * 2 <= size {
            
            let leftChildIndex = index * 2
            let rightChildIndex = index * 2 + 1
            
            var childIndex = leftChildIndex
            
            if rightChildIndex <= size,
               areSorted(heap[rightChildIndex], heap[leftChildIndex]) {
                childIndex = rightChildIndex
            }
            
            if areSorted(heap[index], heap[childIndex]) {
                break
            }
            
            heap.swapAt(index, childIndex)
            index = childIndex
        }

        return min
    }
}

func _11286() {
    let n = Int(readLine()!)!
    
    var heap = AbsMinHeap()
    
    for _ in 0..<n {
        let input = Int(readLine()!)!
        
        if input == 0 {
            // 출력
            print(heap.pop())
        } else {
            heap.push(input)
        }
    }
}
