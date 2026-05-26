//
//  1655.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 10/22/25.
//

import Foundation

/*
 1. FileIO 안써도 되긴 한다.
 2. 매번 print()문 쓰는 것도 시간이 꽤 걸리나 보다.
    - 답을 모아두고 한 번에 프린팅 하니까 시간 초과가 줄어든다.
 
 3. 혹시 몰라서 Heap에서 top을 optional로 선언했다가 옵셔널 벗기는 과정에서
    오래 걸릴까봐 바꿈.
    but, 옵셔널로 다시 제출하니까 풀이 성공!!
 
 -> 결국, 프린팅하는 과정에서 오래 걸린 듯,
    매번, 프린팅하지 말고 한 번에 모아서 한 번만 쓰자.
    (+) print()가 실행될 때 어떻게 되길래 오래 걸릴까..? 알아보기!
 */

func _1655() {
    final class FileIO {
        private let buffer:[UInt8]
        private var index: Int = 0

        init(fileHandle: FileHandle = FileHandle.standardInput) {
            
            buffer = Array(try! fileHandle.readToEnd()!)+[UInt8(0)] // 인덱스 범위 넘어가는 것 방지
        }

        @inline(__always) private func read() -> UInt8 {
            defer { index += 1 }

            return buffer[index]
        }

        @inline(__always) func readInt() -> Int {
            var sum = 0
            var now = read()
            var isPositive = true

            while now == 10
                    || now == 32 { now = read() } // 공백과 줄바꿈 무시
            if now == 45 { isPositive.toggle(); now = read() } // 음수 처리
            while now >= 48, now <= 57 {
                sum = sum * 10 + Int(now-48)
                now = read()
            }

            return sum * (isPositive ? 1:-1)
        }

        @inline(__always) func readString() -> String {
            var now = read()

            while now == 10 || now == 32 { now = read() } // 공백과 줄바꿈 무시
            let beginIndex = index-1

            while now != 10,
                  now != 32,
                  now != 0 { now = read() }

            return String(bytes: Array(buffer[beginIndex..<(index-1)]), encoding: .ascii)!
        }

        @inline(__always) func readByteSequenceWithoutSpaceAndLineFeed() -> [UInt8] {
            var now = read()

            while now == 10 || now == 32 { now = read() } // 공백과 줄바꿈 무시
            let beginIndex = index-1

            while now != 10,
                  now != 32,
                  now != 0 { now = read() }

            return Array(buffer[beginIndex..<(index-1)])
        }
    }
    
    struct Heap {
        private var heap = [0]
        var size = 0
        
        private var areSorted: (Int, Int) -> Bool
        
        var top: Int { size >= 1 ? heap[1] : 0 }
        var isEmpty: Bool { size == 0 ? true : false }
        
        init(areSorted: @escaping (Int, Int) -> Bool) {
            self.areSorted = areSorted
        }
        
        mutating func push(_ value: Int) {
            heap.append(value)
            size += 1
            
            var index = size
            
            while index != 1 {
                let parentIndex = index / 2
                
                if areSorted(heap[parentIndex], heap[index]) { break }
                
                heap.swapAt(parentIndex, index)
                index = parentIndex
            }
        }
        
        
        mutating func pop() -> Int {
            guard !isEmpty else { return 0 }
            
            let top = heap[1]
            heap[1] = heap[size]
            heap.removeLast()
            size -= 1
            
            var index = 1
            
            while 2 * index <= size { // 자식 인덱스가 하나라도 있을 때는 해야 된다 ?!
                let leftChildIndex = 2 * index
                let rightChildIndex = 2 * index + 1
                
                var targetIndex = leftChildIndex
                
                if rightChildIndex <= size, areSorted(heap[rightChildIndex], heap[leftChildIndex]) {
                    targetIndex = rightChildIndex
                }
                
                if areSorted(heap[index], heap[targetIndex]) { break }
                
                heap.swapAt(index, targetIndex)
                index = targetIndex
            }
            
            return top
        }
        
        
    }
    
    let fIO = FileIO()

    let n = fIO.readInt()
    
    var answer = ""
    
    var minHeap = Heap(areSorted: <)
    var maxHeap = Heap(areSorted: >)
    
    for i in 0..<n {
        let value = fIO.readInt()
        
        if i == 0 {
            maxHeap.push(value)
        } else if i == 1 {
            if maxHeap.top <= value {
                minHeap.push(value)
            } else {
                minHeap.push(maxHeap.pop())
                maxHeap.push(value)
            }
        } else {
            if i % 2 == 0 { // maxHeap에 추가

                let minTop = minHeap.top
                
                if minTop >= value {
                    maxHeap.push(value)
                } else {
                    maxHeap.push(minHeap.pop())
                    minHeap.push(value)
                }
                
            } else { // minHeap에 추가
                let maxTop = maxHeap.top
                
                if maxTop <= value {
                    minHeap.push(value)
                } else {
                    minHeap.push(maxHeap.pop())
                    maxHeap.push(value)
                }
            }
        }
        
        answer += "\(maxHeap.top)\n"
    }
    print(answer)
}

func _1655_2() {
    struct Heap {
        private var heap = [0]
        var size = 0
        
        private var areSorted: (Int, Int) -> Bool
        
        var top: Int { size >= 1 ? heap[1] : 0 }
        var isEmpty: Bool { size == 0 ? true : false }
        
        init(areSorted: @escaping (Int, Int) -> Bool) {
            self.areSorted = areSorted
        }
        
        mutating func push(_ value: Int) {
            heap.append(value)
            size += 1
            
            var index = size
            
            while index != 1 {
                let parentIndex = index / 2
                
                if areSorted(heap[parentIndex], heap[index]) { break }
                
                heap.swapAt(parentIndex, index)
                index = parentIndex
            }
        }
        
        
        mutating func pop() -> Int {
            guard !isEmpty else { return 0 }
            
            let top = heap[1]
            heap[1] = heap[size]
            heap.removeLast()
            size -= 1
            
            var index = 1
            
            while 2 * index <= size { // 자식 인덱스가 하나라도 있을 때는 해야 된다 ?!
                let leftChildIndex = 2 * index
                let rightChildIndex = 2 * index + 1
                
                var targetIndex = leftChildIndex
                
                if rightChildIndex <= size, areSorted(heap[rightChildIndex], heap[leftChildIndex]) {
                    targetIndex = rightChildIndex
                }
                
                if areSorted(heap[index], heap[targetIndex]) { break }
                
                heap.swapAt(index, targetIndex)
                index = targetIndex
            }
            
            return top
        }
        
        
    }
    

    let n = Int(readLine()!)!
    
    var answer = ""
    
    var minHeap = Heap(areSorted: <)
    var maxHeap = Heap(areSorted: >)
    
    for i in 0..<n {
        let value = Int(readLine()!)!
        
        if i == 0 {
            maxHeap.push(value)
        } else if i == 1 {
            if maxHeap.top <= value {
                minHeap.push(value)
            } else {
                minHeap.push(maxHeap.pop())
                maxHeap.push(value)
            }
        } else {
            if i % 2 == 0 { // maxHeap에 추가

                let minTop = minHeap.top
                
                if minTop >= value {
                    maxHeap.push(value)
                } else {
                    maxHeap.push(minHeap.pop())
                    minHeap.push(value)
                }
                
            } else { // minHeap에 추가
                let maxTop = maxHeap.top
                
                if maxTop <= value {
                    minHeap.push(value)
                } else {
                    minHeap.push(maxHeap.pop())
                    maxHeap.push(value)
                }
            }
        }
        
        answer += "\(maxHeap.top)\n"
    }
    print(answer)
}

// 처음 풀이에 프린팅 방식만 바꾼 것!
func _1655_first() {
    struct Heap {
        private var heap = [0]
        var size = 0
        
        private var areSorted: (Int, Int) -> Bool
        
        var top: Int? {size >= 1 ? heap[1] : nil }
        var isEmpty: Bool { size == 0 ? true : false }
        
        init(areSorted: @escaping (Int, Int) -> Bool) {
            self.areSorted = areSorted
        }
        
        mutating func push(_ value: Int) {
            heap.append(value)
            size += 1
            
            var index = size
            
            while index != 1 {
                let parentIndex = index / 2
                
                if areSorted(heap[parentIndex], heap[index]) { break }
                
                heap.swapAt(parentIndex, index)
                index = parentIndex
            }
        }
        
        
        mutating func pop() -> Int? {
            guard !isEmpty else { return nil }
            
            let top = heap[1]
            heap[1] = heap[size]
            heap.removeLast()
            size -= 1
            
            var index = 1
            
            while 2 * index <= size {
                let leftChildIndex = 2 * index
                let rightChildIndex = 2 * index + 1
                
                var targetIndex = leftChildIndex
                
                if rightChildIndex <= size, areSorted(heap[rightChildIndex], heap[leftChildIndex]) {
                    targetIndex = rightChildIndex
                }
                
                if areSorted(heap[index], heap[targetIndex]) { break }
                
                heap.swapAt(index, targetIndex)
                index = targetIndex
            }
            
            return top
        }
        
        
    }
    
    let n = Int(readLine()!)!
    var answer = ""
    var minHeap = Heap(areSorted: <)
    var maxHeap = Heap(areSorted: >)
    
    for _ in 0..<n {
        let value = Int(readLine()!)!
        
        let minSize = minHeap.size
        let maxSize = maxHeap.size
        
        if minSize == maxSize {
            guard let minTop = minHeap.top else {
                maxHeap.push(value)
                
                answer += "\(maxHeap.top!)\n"
                continue
            }
            
            if minTop >= value {
                maxHeap.push(value)
            } else {
                maxHeap.push(minHeap.pop()!)
                minHeap.push(value)
            }
            
        } else {
            guard let maxTop = maxHeap.top else { continue }
            
            if maxTop <= value {
                minHeap.push(value)
            } else {
                minHeap.push(maxHeap.pop()!)
                maxHeap.push(value)
            }
        }
        
        answer += "\(maxHeap.top!)\n"
    }
    print(answer)
}
