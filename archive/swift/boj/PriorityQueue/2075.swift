//
//  2075.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 10/21/25.
//

import Foundation

 /*
  - 시간 초과 풀이
  
func _2075() {
    let n = Int(readLine()!)!
    
    var table = [[Int]](repeating: [], count: n)
    
    for _ in 0..<n {
        let row = readLine()!.split(separator: " ").map { Int($0)! }
        
        for i in 0..<n {
            table[i].append(row[i])
        }
    }
    
    var ans = 0
    
    for k in 0..<n {
        var max = Int.min
        var maxIndex = -1
        
        for (index, row) in table.enumerated() {
            if max <= row.last! {
                maxIndex = index
                max = row.last!
            }
        }

        ans = table[maxIndex].removeLast()
    }
    
    print(ans)
}
  */
  
/*
// Heap을 이용해서 좀 더 빨리 최대 값을 갖는 배열 찾아보기
func _2075() {
    struct MaxHeap {
        private var heap: [[Int]] = [[]]
        private var size = 0
        
        private var areSorted: ([Int], [Int]) -> Bool = {
            $0.last ?? 0 >= $1.last ?? 0
        }
        
        mutating func push(_ n: [Int]) {
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
        
        mutating func pop() -> [Int] {
            guard size > 0 else { return [] }
            
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
    
    let n = Int(readLine()!)!
    
    var table = [[Int]](repeating: [], count: n)
    
    for _ in 0..<n {
        let row = readLine()!.split(separator: " ").map { Int($0)! }
        
        for i in 0..<n {
            table[i].append(row[i])
        }
    }
    
    var maxHeap = MaxHeap()
    table.forEach { maxHeap.push($0) }
    
    var ans = 0
    
    for _ in 0..<n {
        var maxRow = maxHeap.pop()
        ans = maxRow.removeLast()
        
        maxHeap.push(maxRow)
    }
    
    print(ans)
}
 */


/*
 요건 좀 억울한 풀이..(아닐지도 🤔)
 
 위의 풀이가 좀 더 빠를 거 같은데..
 아닌가..? 배열을 갖는 힙을 만들어서 n이 1500 이하라고 생각했는데,
 이걸 만들면서 n * n 만큼 다 돌면서 table을 만들긴 하네 ㅎ
 그럼 여기서 애초에 O(n^2)
 그리고 heap 만들 때 O(nlogn)
 답 구하는 과정에서도 O(nlogn)
 
 결국, 위의 풀이에서도 시간 복잡도는 O(n^2)..?
 그럼 table 만드는 걸 줄여야 되는거네..
 
 sort()나 make_heap()이나 최악으로 보면 O(nlogn)
 ✍🏻: 다시 찾아보니 make_heap은 엄밀히 말하면 O(n)!!
    heap_sort가 O(nlogn)
    -> 여기서 말하는 N이랑 실제 데이터 개수 N * N 을 잘 구분해서 생각해보면 좋을 듯
 
 그럼 heap으로 푸는 거나 sort로 푸는 거나 같다고 보면 그 이상 시간이 걸리는 곳이 있다면
 그걸 줄이는게 맞는 건가..
 
 결국, input 값을 갖는 것보다 시간 복잡도가 낮은 풀이로 문제가 풀린다면
 Swift는 input을 더 빨리 파싱하는게 관건인듯 ?!
 ex, N x N 의 값들을 파싱할 때 ?
 
 생각보다 sort()도 빠르다!!!
 */
func _2075() {
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

    let fIO = FileIO()

    let N = fIO.readInt()
    var arr = [Int]()

    for _ in 0..<N*N {
        let input = fIO.readInt()
        arr.append(input)
    }
    
    arr.sort()
    print(arr[N*N-N])
}

func _2075_2() {
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

    let fIO = FileIO()

    let N = fIO.readInt()
    var arr = [Int]()

    for _ in 0..<N*N {
        let input = fIO.readInt()
        arr.append(input)
    }
    
    arr.sort()
    print(arr[N*N-N])
}
