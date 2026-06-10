//
//  Singly Linked List.swift
//  SwiftAlgorithm
//
//  Created by zaehorang on 6/9/26.
//

import Foundation

// Singly Linked List
//
// 각 노드가 value와 다음 노드에 대한 참조(next)를 가진다.
// 배열과 달리 중간 삽입/삭제 시 요소들을 한 칸씩 밀 필요는 없지만,
// 특정 위치에 접근하려면 head부터 순차적으로 이동해야 한다.
struct SinglyLinkedList<Element> {
    private final class Node {
        var value: Element
        var next: Node?
        
        init(_ value: Element) {
            self.value = value
        }
    }
    
    private var head: Node?
    private var tail: Node?
    private(set) var count: Int = 0
    
    // 리스트가 비어 있는지 확인한다.
    // Time: O(1)
    var isEmpty: Bool {
        count == 0
    }
    
    // 첫 번째 값을 제거하지 않고 확인한다.
    // Time: O(1)
    func first() -> Element? {
        head?.value
    }
    
    // 마지막 값을 제거하지 않고 확인한다.
    // tail을 가지고 있으므로 O(1)에 확인할 수 있다.
    // Time: O(1)
    func last() -> Element? {
        tail?.value
    }
    
    // 리스트의 앞에 값을 추가한다.
    // Time: O(1)
    mutating func prepend(_ value: Element) {
        let newNode = Node(value)
        
        if isEmpty {
            head = newNode
            tail = newNode
        } else {
            newNode.next = head
            head = newNode
        }
        
        count += 1
    }
    
    // 리스트의 뒤에 값을 추가한다.
    // tail을 가지고 있으므로 끝까지 순회하지 않고 O(1)에 추가할 수 있다.
    // Time: O(1)
    mutating func append(_ value: Element) {
        let newNode = Node(value)
        
        if isEmpty {
            head = newNode
            tail = newNode
        } else {
            tail?.next = newNode
            tail = newNode
        }
        
        count += 1
    }
    
    // 리스트의 첫 번째 값을 제거하고 반환한다.
    // Time: O(1)
    @discardableResult
    mutating func removeFirst() -> Element? {
        guard let currentHead = head else {
            return nil
        }
        
        head = currentHead.next
        count -= 1
        
        // 마지막 원소를 제거한 경우 tail도 nil로 맞춘다.
        if isEmpty {
            tail = nil
        }
        
        return currentHead.value
    }
    
    // 리스트의 마지막 값을 제거하고 반환한다.
    // Singly Linked List는 이전 노드로 바로 이동할 수 없기 때문에
    // 마지막 직전 노드를 찾기 위해 head부터 순회해야 한다.
    // Time: O(n)
    @discardableResult
    mutating func removeLast() -> Element? {
        guard let head else {
            return nil
        }
        
        // 노드가 하나뿐인 경우
        if head.next == nil {
            let value = head.value
            self.head = nil
            self.tail = nil
            count = 0
            return value
        }
        
        var current: Node? = head
        
        // current.next가 tail이 될 때까지 이동한다.
        // Node는 Class이므로 인스턴스 비교 문법 사용
        while current?.next !== tail {
            current = current?.next
        }
        
        let value = tail?.value
        current?.next = nil
        tail = current
        count -= 1
        
        return value
    }
    
    // 리스트의 모든 값을 배열로 변환한다.
    // Time: O(n)
    func toArray() -> [Element] {
        var result: [Element] = []
        var current = head
        
        while let node = current {
            result.append(node.value)
            current = node.next
        }
        
        return result
    }
    
    // 리스트의 모든 값을 제거한다.
    // Time: O(1)
    mutating func removeAll() {
        head = nil
        tail = nil
        count = 0
    }
}

extension SinglyLinkedList where Element: Equatable {
    // 특정 값이 리스트에 있는지 확인한다.
    // Time: O(n)
    func contains(_ value: Element) -> Bool {
        var current = head
        
        while let node = current {
            if node.value == value {
                return true
            }
            
            current = node.next
        }
        
        return false
    }
}
