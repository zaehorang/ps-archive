//
//  Heap.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 9/18/25.
//

import Foundation

struct Heap<T: Comparable> {
    private var elements: [T] = [] // 0번은 패딩용
    private let areSorted: (T, T) -> Bool
    
    var isEmpty: Bool { elements.count <= 1 }
    var count: Int { max(elements.count - 1, 0) }  // 마지막 노드 인덱스랑 같음
    var peek: T? { isEmpty ? nil : elements[1] }
    
    init(areSorted: @escaping (T, T) -> Bool) {
        self.areSorted = areSorted
    }
    
    init(_ array: [T], areSorted: @escaping (T, T) -> Bool) {
        self.areSorted = areSorted
        if !array.isEmpty {
            self.elements = [array.first!] // 먼저 더미 자리만 차지
            self.elements.append(contentsOf: array) // 실제 데이터는 1부터
            makeHeap()
        }
    }
    
    private func leftChildIndex(of index: Int) -> Int { index * 2 }
    private func rightChildIndex(of index: Int) -> Int { index * 2 + 1 }
    private func parentIndex(of index: Int) -> Int { index / 2 }
    
    /// O(log n) = O(h)
    private mutating func heapifyDown(from index: Int, until end: Int) {
        var k = index
        
        while leftChildIndex(of: k) <= end { // 리프 노드가 아닐 때까지
            let left = leftChildIndex(of: k)
            let right = rightChildIndex(of: k)
            
            var candidate = left
            if right <= end, areSorted(elements[right], elements[left]) {
                candidate = right
            }
            
            if areSorted(elements[k], elements[candidate]) { break }
            elements.swapAt(k, candidate)
            k = candidate
        }
    }
    
    /// O(log n) = O(h)
    private mutating func heapifyUp(from index: Int) {
        var k = index
        while k > 1 {
            let p = parentIndex(of: k)
            if areSorted(elements[p], elements[k]) { break }
            elements.swapAt(p, k)
            k = p
        }
    }
    
    /// O(n)
    private mutating func makeHeap() {
        guard count > 1 else { return }
        
        // 마지막 리프 노드의 부모부터 확인하면 된다.
        for i in stride(from: count / 2, through: 1, by: -1) {
            heapifyDown(from: i, until: count)
        }
    }
    
    /// O(log n) = O(h)
    mutating func insert(_ value: T) {
        if elements.isEmpty {
            elements.append(value) // index 0 더미 자리 확보
        }
        elements.append(value)
        heapifyUp(from: count)
    }
    
    /// O(log n) = O(h)
    mutating func popTop() -> T? {
        guard !isEmpty else { return nil }
        if count == 1 { return elements.removeLast() }
        
        elements.swapAt(1, count)
        let popped = elements.removeLast()
        heapifyDown(from: 1, until: count)
        
        return popped
    }
    
    /// O(nlog n): 루트 노드와 마지막 노드를 자리바꿈하고 heapify하는데 필요한 시간
    func heapSorted() -> [T] {
        var copy = self
        var out: [T] = []
        out.reserveCapacity(copy.count)
        while let v = copy.popTop() {
            out.append(v)
        }
        return out
    }
}

extension Heap where T == Int {
    static func runTests() {
        // 한 곳에서 모든 테스트 시나리오 실행
        testMaxHeap()
        testMinHeap()
        testHeapSort()
        testEdgeCases()
    }
    
    private static func testMaxHeap() {
        var h = Heap<Int>(areSorted: >)
        h.insert(7); h.insert(3); h.insert(10); h.insert(5)
        printResult(h.peek, expected: 10, prefix: "MaxHeap peek")
        var out: [Int] = []
        while let v = h.popTop() { out.append(v) }
        printResult(out, expected: [10, 7, 5, 3], prefix: "MaxHeap pop")
    }
    
    private static func testMinHeap() {
        var h = Heap([5, 3, 10, 7, 1], areSorted: <)
        printResult(h.peek, expected: 1, prefix: "MinHeap peek")
        var out: [Int] = []
        while let v = h.popTop() { out.append(v) }
        printResult(out, expected: [1, 3, 5, 7, 10], prefix: "MinHeap pop")
    }
    
    private static func testHeapSort() {
        let maxSorted = Heap([8, 1, 6, 3, 5], areSorted: >).heapSorted()
        printResult(maxSorted, expected: [8, 6, 5, 3, 1], prefix: "MaxHeap sort")
        
        let minSorted = Heap([8, 1, 6, 3, 5], areSorted: <).heapSorted()
        printResult(minSorted, expected: [1, 3, 5, 6, 8], prefix: "MinHeap sort")
    }
    
    private static func testEdgeCases() {
        var empty = Heap<Int>(areSorted: >)
        printResult(empty.popTop() as Int?, expected: nil, prefix: "빈 힙 pop")
        
        var single = Heap<Int>(areSorted: >)
        single.insert(42)
        printResult(single.popTop(), expected: 42, prefix: "단일 pop")
        printResult(single.isEmpty, expected: true, prefix: "단일 pop 후 비었나")
    }
    
    // 출력 유틸
    private static func printResult<U: Equatable>(_ actual: U, expected: U, prefix: String = "") {
        print("\(prefix) 결과:", actual, actual == expected ? "✅" : "❌ 기대:", expected)
    }
    private static func printResult<U: Equatable>(_ actual: U?, expected: U?, prefix: String = "") {
        print("\(prefix) 결과:", String(describing: actual),
              actual == expected ? "✅" : "❌ 기대:", String(describing: expected))
    }
}

// MARK: - 간단 버전
struct EashHeap<T: Comparable> {
    private var heap: [T] = []
    private var size = 0
    
    let areSorted: (T, T) -> Bool
    
    init(areSorted: @escaping (T, T) -> Bool) {
        self.areSorted = areSorted
    }
    
    func top() -> T? { size >= 1 ? heap[0] : nil }
    
    mutating func push(_ value: T) {
        if heap.isEmpty { // 0번 인덱스 미리 채우기
            heap.append(value)
        }
        
        size += 1
        heap.append(value)
        
        var index = size
        
        while index != 1 {
            let parentIndex = index / 2
            if areSorted(heap[parentIndex], heap[index]) {
                break
            }
            
            heap.swapAt(index, parentIndex)
            index = parentIndex
        }
    }
    
    mutating func pop() {
        heap[1] = heap[size]
        heap.removeLast()
        size -= 1
        
        var index = 1
        
        // 왼쪽 자식의 인덱스(index * 2)가 size보다 크면 index는 리프 노드
        while index * 2 <= size {
            let leftChildIndex = index * 2
            let rightChildIndex = index * 2 + 1
            
            var targetChildIndex = leftChildIndex
            
            if rightChildIndex <= size,
                areSorted(heap[rightChildIndex], heap[leftChildIndex]) {
                targetChildIndex = rightChildIndex
            }
            
            if areSorted(heap[index], heap[targetChildIndex]) {
                break
            }
            heap.swapAt(index, targetChildIndex)
            
            index = targetChildIndex
        }
    }
}

extension EashHeap where T == Int {
    mutating func testMin(){
        push(10)
        push(2)
        push(5)
        push(9)
        
        print(heap) // [10, 2, 9, 5, 10]
        print("테스트 결과:", heap == [10, 2, 5, 10, 9])
        
        pop() // pop: 2
        pop() // pop: 5
        print(heap) // [10, 9, 10]
        print("테스트 결과:", heap == [10, 9, 10])
        
        push(5)
        push(15)
        print(heap) // [10, 5, 10, 9, 15]
        print("테스트 결과:", heap == [10, 5, 10, 9, 15])
        
        pop() // pop: 5
        print(heap) // [10, 9, 10, 15]
        print("테스트 결과:", heap == [10, 9, 10, 15])
    }
}
