//
//  1715.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 10/20/25.
//

import Foundation

/*
 실패 풀이
 원인:
 무조건 섞인 카드에 다른 카드를 섞는다고 생각해서 순차적으로만 생각했지만,
 섞인 묶음 끼리도 섞일 수 있음.
 
func _1715() {
    let n = Int(readLine()!)!
    
    var cards = [0]
    
    for _ in 0..<n {
        cards.append(Int(readLine()!)!)
    }
    
    // 카드 묶음이 한 개면 섞지 않아도 된다.
    guard n > 1 else {
        print(0)
        return
    }
    
    cards.sort()
    
    var dp = [0, cards[1]]
    var ans = 0
    
    for a in 2...n {
        let n = dp[a-1] + cards[a]
        dp.append(n)
        ans += n
    }
    
    print(ans)
}
 */

func _1715() {
    struct MinHeap {
        private var heap: [Int] = []
        private var size = 0
        
        let areSorted: (Int, Int) -> Bool = {
            $0 <= $1
        }
        
        var isEmpty: Bool { size == 0 ? true : false }
        
       mutating func push(_ elem: Int) {
            if heap.isEmpty {
                heap.append(elem)
            }
           
           size += 1
           heap.append(elem)
           
           var index = size
           
           while index != 1 {
               let parentIndex = index / 2
               
               if areSorted(heap[parentIndex], elem) { break }
               
               heap.swapAt(index, parentIndex)
               index = parentIndex
           }
        }
        
        mutating func pop() -> Int {
            let min = heap[1]
            heap[1] = heap[size]
            heap.removeLast()
            size -= 1
            
            var index = 1
            
            while index * 2 <= size {
                let leftChildIndex = index * 2
                let rightChildIndex = index * 2 + 1
                
                var targetChildIndex = leftChildIndex
                
                if rightChildIndex <= size, areSorted(heap[rightChildIndex], heap[leftChildIndex]) {
                    targetChildIndex = rightChildIndex
                }
             
                if areSorted(heap[index], heap[targetChildIndex]) {
                    break
                }
                heap.swapAt(index, targetChildIndex)
                index = targetChildIndex
                
            }
            return min
        }
    }
    
    /// 풀이
    let n = Int(readLine()!)!
    
    // 카드 묶음이 한 개면 섞지 않아도 된다.
    guard n > 1 else {
        print(0)
        return
    }
    
    var cards = MinHeap()
    
    for _ in 0..<n {
        cards.push(Int(readLine()!)!)
    }
    
    // TODO: 두 개씩 빼서 ans 구하기
    var ans = 0
    
    while !cards.isEmpty {
        let min1 = cards.pop()
        let min2 = cards.pop()
        
        let sum = min1 + min2
        ans += sum
        
        if cards.isEmpty { break }
        cards.push(sum)
    }
    
    print(ans)
}
