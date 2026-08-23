//
//  1766.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 12/13/25.
//
//  https://www.acmicpc.net/problem/1766

import Foundation

/*
 - 문제들 사이에 우선순위가 있다.
 - 모든 문제를 탐색해야 한다.
 
 - 우선순위 후보군(indegrees == 0)에서 난이도가 최소인 문제를 우선적으로 뽑아야 한다.
 - 문제를 뽑고 새로운 후보가 후보군에 들어가게 되면 내부에서 우선순위가 바뀔 수 있다.
 
 -> 우선 순위로 인해 선후 관계가 있기 때문에 위상 정렬 생각.
 -> 매번 우선순위가 최소인 문제를 찾아야 하기 때문에 최소 힙 생각.
 
 - 힙 연산 비용: O(N log N)
 - 그래프 순회 비용: O(M)
 */

func _1766() {
    struct MinHeap {
        private var heap: [Int] = [0]
        private var size = 0
        
        let areSorted: (Int, Int) -> Bool = {
            $0 <= $1
        }
        
        var isEmpty: Bool { size == 0 ? true : false }
        
        /// O(logN)
        mutating func push(_ elem: Int) {
            heap.append(elem)
            size += 1
            
            var index = size
            
            while index != 1 {
                let parentIndex = index / 2
                
                if areSorted(heap[parentIndex], elem) { break }
                heap.swapAt(index, parentIndex)
                index = parentIndex
            }
        }
        
        /// O(logN)
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
    
    let NM = readLine()!.split(separator: " ").map { Int($0)! }
    let (N, M) = (NM[0], NM[1])
    
    var indegrees: [Int] = .init(repeating: 0, count: N + 1)
    var graph: [[Int]] = .init(repeating: [], count: N + 1)
    
    for _ in 0..<M {
        let ab = readLine()!.split(separator: " ").map { Int($0)! }
        let (a, b) = (ab[0], ab[1])
        
        graph[a].append(b)
        indegrees[b] += 1
    }
    
    var ans: [Int] = []
    var heap = MinHeap()
    
    /// O(N log N)
    for i in 1...N where indegrees[i] == 0 {
        heap.push(i)
    }
    
    while !heap.isEmpty {
        let top = heap.pop()
        ans.append(top)
        
        /// O(M)
        for i in graph[top] {
            indegrees[i] -= 1
            if indegrees[i] == 0 { heap.push(i)}
        }
    }
    
    let ansString = ans
        .map{ String($0) }
        .joined(separator: " ")
    
    print(ansString)
}
