//
//  1781.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 11/10/25.
//

/*
 시간 초과;;;
 */

func _1781() {
    struct MaxHeap {
        private var heap: [Int] = []
        private var size = 0
        
        let areSorted: (Int, Int) -> Bool = {
            $0 >= $1
        }
        
        var isEmpty: Bool { size == 0 ? true : false }
        var max: Int { heap[1] }
        
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
            let max = heap[1]
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
            return max
        }
    }
    
    
    let N = Int(readLine()!)!
    
    var deadLines: Set<Int> = []
    
    var table: [Int: MaxHeap] = .init()
    for _ in 0..<N {
        let ab = readLine()!.split(separator: " ").map { Int($0)! }
        
        table[ab[0], default: MaxHeap()].push(ab[1])
        
        deadLines.insert(ab[0])
    }
    
    var ans = 0
    let maxDeadLine = deadLines.max() ?? 0
    
    for i in (1...maxDeadLine).reversed() {
        var max = 0
        var index = -1
        
        for j in i...maxDeadLine {
            guard let l = table[j], !l.isEmpty else { continue }
            
            let a = table[j]?.max ?? 0
            
            if max < a {
                max = a
                index = j
            }
        }
        
        ans += max
        let _ = table[index]?.pop()
    }
    
    print(ans)
}

/*
 이전 풀이랑 달라진 점
 
 - 뒤에서 부터 큰 걸 고르는 건 같음
 - but, 데드라인 인덱스를 앞으로 옮길 때마다 매번 새로운 배열을 만들어서 최대값을 골라주었음. but, 데드라인이 이후인 것들은 앞으로 이동할 때 계속 값이 유지 되므로(최대를 제외한 상태니까 선택지로 가능) 새로 만들 필요 없이 max heap을 그대로 가져도 된다.
 */

func _1781_() {
    struct MaxHeap {
        private var heap: [Int] = []
        private var size = 0
        
        let areSorted: (Int, Int) -> Bool = {
            $0 >= $1
        }
        
        var isEmpty: Bool { size == 0 ? true : false }
        var max: Int { heap[1] }
        
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
            let max = heap[1]
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
            return max
        }
    }
    
    
    let N = Int(readLine()!)!
    
    var deadLines: Set<Int> = []
    
    var table: [Int: [Int]] = .init()
    for _ in 0..<N {
        let ab = readLine()!.split(separator: " ").map { Int($0)! }
        
        table[ab[0], default: []].append(ab[1])
        
        deadLines.insert(ab[0])
    }
    
    var ans = 0
    let maxDeadLine = deadLines.max() ?? 0
    
    var heap: MaxHeap = .init()
    
    for i in (1...maxDeadLine).reversed() {
        for k in table[i] ?? [] {
            heap.push(k)
        }
        guard !heap.isEmpty else { continue }
        ans += heap.pop()
    }
    
    print(ans)
}



/*
 반례
 
 1
 3 10
 
 ->10
 
 3
 3 9
 3 4
 1 1
 
 -> 14
 
 
 4
 1 1
 2 1
 3 10
 3 10
 
 A : 21
 
 4
 1 50
 2 30
 3 60
 3 70
 
 -> 180
 
 7
 3 5
 3 5
 3 5
 3 5
 3 5
 3 5
 3 5
 
 정답: 15
 */
