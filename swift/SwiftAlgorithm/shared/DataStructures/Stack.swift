//
//  Stack.swift
//  SwiftAlgorithm
//
//  Created by zaehorang on 6/9/26.
//

import Foundation

// Stack
//
// Last In, First Out(LIFO) 구조이다.
// 가장 마지막에 들어온 값이 가장 먼저 나간다.
//
// Array의 마지막 인덱스를 top으로 사용하면 push/pop이 평균 O(1)이다.
// 반대로 첫 번째 인덱스를 top으로 쓰면 removeFirst()가 O(n)이므로 비효율적이다.
struct Stack<Element> {
    private var elements: [Element] = []
    
    // 현재 스택에 들어 있는 원소 개수
    // Time: O(1)
    var count: Int {
        elements.count
    }
    
    // 스택이 비어 있는지 확인
    // Time: O(1)
    var isEmpty: Bool {
        elements.isEmpty
    }
    
    // 스택의 가장 위에 값을 추가한다.
    // Time: 평균 O(1)
    // Space: O(1)
    mutating func push(_ element: Element) {
        elements.append(element)
    }
    
    // 스택의 가장 위 값을 제거하고 반환한다.
    // 비어 있으면 nil을 반환한다.
    // Time: O(1)
    // Space: O(1)
    @discardableResult
    mutating func pop() -> Element? {
        // removeLast()는 빈 배열에서 런타임 에러 발생
        // popLast()는 빈 배열이면 nil 반환
        elements.popLast()
    }
    
    // 스택의 가장 위 값을 제거하지 않고 확인한다.
    // 비어 있으면 nil을 반환한다.
    // Time: O(1)
    // Space: O(1)
    func peek() -> Element? {
        elements.last
    }
    
    // 스택의 모든 값을 제거한다.
    // Time: O(n)
    // Space: O(1)
    mutating func clear() {
        elements.removeAll()
    }
}
