//
//  Queue.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 5/1/24.
//

import Foundation

// Queue
//
// First In, First Out(FIFO) 구조이다.
// 가장 먼저 들어온 값이 가장 먼저 나간다.
//
// Array의 removeFirst()는 앞 요소를 제거한 뒤 나머지 요소를 모두 앞으로 당겨야 하므로 O(n)이다.
// 따라서 실제 제거 대신 head 인덱스를 이동시키는 방식으로 dequeue를 O(1)에 가깝게 처리한다.
struct Queue<Element> {
    private var elements: [Element?] = []
    private var head: Int = 0
    
    // 현재 큐에 남아 있는 원소 개수
    // Time: O(1)
    var count: Int { elements.count - head }
    
    // 큐가 비어 있는지 확인
    // Time: O(1)
    var isEmpty: Bool { count == 0 }
    
    // 큐의 맨 앞 값을 제거하지 않고 확인한다.
    // 비어 있으면 nil을 반환한다.
    // Time: O(1)
    func peek() -> Element? {
        isEmpty ? nil : elements[head]
    }
    
    // 큐의 뒤에 값을 추가한다.
    // Time: 평균 O(1)
    // Space: O(1)
    mutating func enqueue(_ element: Element) {
        elements.append(element)
    }
    
    // 큐의 맨 앞 값을 제거하고 반환한다.
    // 비어 있으면 nil을 반환한다.
    // Time: 평균 O(1)
    // Space: O(1)
    @discardableResult
    mutating func dequeue() -> Element? {
        guard !isEmpty, let element = elements[head] else {
            return nil
        }
        
        // 실제로 removeFirst()를 호출하지 않고 nil로 비운 뒤 head만 이동한다.
        // removeFirst()는 O(n)이기 때문에 큐 구현에는 비효율적이다.
        elements[head] = nil
        head += 1
        
        // 앞쪽에 nil이 너무 많이 쌓이면 메모리 낭비가 생긴다.
        // 일정 기준을 넘었을 때만 배열을 정리해서 매번 O(n) 정리가 발생하지 않게 한다.
        let removedRatio = Double(head) / Double(elements.count)
        
        if removedRatio > 0.25 && head > 50 {
            elements.removeFirst(head)
            head = 0
        }
        
        return element
    }
    
    // 큐의 모든 값을 제거한다.
    // Time: O(n)
    // Space: O(1)
    mutating func removeAll() {
        elements.removeAll()
        head = 0
    }
}
