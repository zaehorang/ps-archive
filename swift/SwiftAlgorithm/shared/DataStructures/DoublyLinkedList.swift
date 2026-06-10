//
//  DoublyLinkedList.swift
//  SwiftAlgorithm
//
//  Created by zaehorang on 6/10/26.
//

import Foundation

// Doubly Linked List
//
// 각 노드가 이전 노드(prev)와 다음 노드(next)를 모두 가진다.
// Singly Linked List와 달리 이전 노드로 바로 이동할 수 있으므로,
// 특정 노드를 알고 있다면 그 노드의 삭제는 O(1)에 가능하다.
//
// 이 구현은 dummy sentinel node를 사용하는 circular doubly linked list이다.
// sentinel.next는 첫 번째 노드, sentinel.prev는 마지막 노드를 가리킨다.
// 리스트가 비어 있으면 sentinel.next와 sentinel.prev가 자기 자신을 가리킨다.
struct DoublyLinkedList<Element> {
    private final class Node {
        var value: Element?
        var prev: Node?
        var next: Node?
        
        init(_ value: Element? = nil) {
            self.value = value
        }
    }
    
    // sentinel: 보초; Dummy
    private let sentinel = Node()
    private(set) var count: Int = 0
    
    init() {
        sentinel.prev = sentinel
        sentinel.next = sentinel
    }
    
    // 리스트가 비어 있는지 확인한다.
    // Time: O(1)
    var isEmpty: Bool {
        count == 0
    }
    
    // 첫 번째 값을 제거하지 않고 확인한다.
    // Time: O(1)
    func first() -> Element? {
        isEmpty ? nil : sentinel.next?.value
    }
    
    // 마지막 값을 제거하지 않고 확인한다.
    // Time: O(1)
    func last() -> Element? {
        isEmpty ? nil : sentinel.prev?.value
    }
    
    // 리스트의 앞에 값을 추가한다.
    // Time: O(1)
    mutating func prepend(_ value: Element) {
        insert(value, after: sentinel)
    }
    
    // 리스트의 뒤에 값을 추가한다.
    // Time: O(1)
    mutating func append(_ value: Element) {
        insert(value, after: sentinel.prev!)
    }
    
    // target 바로 뒤에 새 노드를 삽입한다.
    // Time: O(1)
    private mutating func insert(_ value: Element, after target: Node) {
        let newNode = Node(value)
        let nextNode = target.next!
        
        newNode.prev = target
        newNode.next = nextNode
        
        target.next = newNode
        nextNode.prev = newNode
        
        count += 1
    }
    
    // 리스트의 첫 번째 값을 제거하고 반환한다.
    // Time: O(1)
    @discardableResult
    mutating func removeFirst() -> Element? {
        guard !isEmpty, let firstNode = sentinel.next else {
            return nil
        }
        
        return remove(firstNode)
    }
    
    // 리스트의 마지막 값을 제거하고 반환한다.
    // Singly Linked List와 달리 prev가 있으므로 O(1)에 제거할 수 있다.
    // Time: O(1)
    @discardableResult
    mutating func removeLast() -> Element? {
        guard !isEmpty, let lastNode = sentinel.prev else {
            return nil
        }
        
        return remove(lastNode)
    }
    
    // target 노드를 리스트에서 제거하고 값을 반환한다.
    // Time: O(1)
    private mutating func remove(_ target: Node) -> Element? {
        let prevNode = target.prev!
        let nextNode = target.next!
        
        prevNode.next = nextNode
        nextNode.prev = prevNode
        
        count -= 1
        
        return target.value
    }
    
    // 리스트의 모든 값을 배열로 변환한다.
    // Time: O(n)
    func toArray() -> [Element] {
        var result: [Element] = []
        var current = sentinel.next
        
        while current !== sentinel {
            if let value = current?.value {
                result.append(value)
            }
            
            current = current?.next
        }
        
        return result
    }
    
    // 리스트의 모든 값을 제거한다.
    // Time: O(1)
    mutating func removeAll() {
        sentinel.next = sentinel
        sentinel.prev = sentinel
        count = 0
    }
}

extension DoublyLinkedList where Element: Equatable {
    // 특정 값이 리스트에 있는지 확인한다.
    // Time: O(n)
    func contains(_ value: Element) -> Bool {
        var current = sentinel.next
        
        while current !== sentinel {
            if current?.value == value {
                return true
            }
            
            current = current?.next
        }
        
        return false
    }
}


// MARK: - Doubly Linked List with dummy head and dummy tail

// circular sentinel 방식과 달리 headDummy와 tailDummy 두 개의 더미 노드를 사용한다.
// headDummy.next는 첫 번째 실제 노드, tailDummy.prev는 마지막 실제 노드를 가리킨다.
// 리스트가 비어 있으면 headDummy.next는 tailDummy, tailDummy.prev는 headDummy를 가리킨다.
//
// LRU Cache를 구현할 때 자주 사용하는 형태이다.
// head 쪽을 최근 사용, tail 쪽을 오래된 사용으로 두면 설명이 직관적이다.
struct HeadTailDoublyLinkedList<Element> {
    private final class Node {
        var value: Element?
        var prev: Node?
        var next: Node?
        
        init(_ value: Element? = nil) {
            self.value = value
        }
    }
    
    private let headDummy = Node()
    private let tailDummy = Node()
    private(set) var count: Int = 0
    
    init() {
        headDummy.next = tailDummy
        tailDummy.prev = headDummy
    }
    
    // 리스트가 비어 있는지 확인한다.
    // Time: O(1)
    var isEmpty: Bool {
        count == 0
    }
    
    // 첫 번째 값을 제거하지 않고 확인한다.
    // Time: O(1)
    func first() -> Element? {
        isEmpty ? nil : headDummy.next?.value
    }
    
    // 마지막 값을 제거하지 않고 확인한다.
    // Time: O(1)
    func last() -> Element? {
        isEmpty ? nil : tailDummy.prev?.value
    }
    
    // 리스트의 앞에 값을 추가한다.
    // headDummy 바로 뒤에 삽입한다.
    // Time: O(1)
    mutating func prepend(_ value: Element) {
        insert(value, after: headDummy)
    }
    
    // 리스트의 뒤에 값을 추가한다.
    // tailDummy 바로 앞, 즉 tailDummy.prev 뒤에 삽입한다.
    // Time: O(1)
    mutating func append(_ value: Element) {
        insert(value, after: tailDummy.prev!)
    }
    
    // target 바로 뒤에 새 노드를 삽입한다.
    // Time: O(1)
    private mutating func insert(_ value: Element, after target: Node) {
        let newNode = Node(value)
        let nextNode = target.next!
        
        newNode.prev = target
        newNode.next = nextNode
        
        target.next = newNode
        nextNode.prev = newNode
        
        count += 1
    }
    
    // 리스트의 첫 번째 값을 제거하고 반환한다.
    // Time: O(1)
    @discardableResult
    mutating func removeFirst() -> Element? {
        guard !isEmpty, let firstNode = headDummy.next else {
            return nil
        }
        
        return remove(firstNode)
    }
    
    // 리스트의 마지막 값을 제거하고 반환한다.
    // Time: O(1)
    @discardableResult
    mutating func removeLast() -> Element? {
        guard !isEmpty, let lastNode = tailDummy.prev else {
            return nil
        }
        
        return remove(lastNode)
    }
    
    // target 노드를 리스트에서 제거하고 값을 반환한다.
    // Time: O(1)
    private mutating func remove(_ target: Node) -> Element? {
        let prevNode = target.prev!
        let nextNode = target.next!
        
        prevNode.next = nextNode
        nextNode.prev = prevNode
        
        count -= 1
        
        return target.value
    }
    
    // 리스트의 모든 값을 배열로 변환한다.
    // Time: O(n)
    func toArray() -> [Element] {
        var result: [Element] = []
        var current = headDummy.next
        
        while current !== tailDummy {
            if let value = current?.value {
                result.append(value)
            }
            
            current = current?.next
        }
        
        return result
    }
    
    // 리스트의 모든 값을 제거한다.
    // Time: O(1)
    mutating func removeAll() {
        headDummy.next = tailDummy
        tailDummy.prev = headDummy
        count = 0
    }
}

extension HeadTailDoublyLinkedList where Element: Equatable {
    // 특정 값이 리스트에 있는지 확인한다.
    // Time: O(n)
    func contains(_ value: Element) -> Bool {
        var current = headDummy.next
        
        while current !== tailDummy {
            if current?.value == value {
                return true
            }
            
            current = current?.next
        }
        
        return false
    }
}
