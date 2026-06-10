//
//  Deque.swift
//  SwiftAlgorithm
//
//  Created by zaehorang on 6/10/26.
//

import Foundation

struct Deque<Element> {
    private var elements: [Element?]
    private var head: Int = 0
    private(set) var count: Int = 0

    init(capacity: Int = 8) {
        self.elements = Array(repeating: nil, count: capacity)
    }

    var isEmpty: Bool {
        count == 0
    }

    private var capacity: Int {
        elements.count
    }

    private func index(_ i: Int) -> Int {
        (i + capacity) % capacity
    }

    func peekFront() -> Element? {
        guard !isEmpty else { return nil }
        return elements[head]
    }

    func peekBack() -> Element? {
        guard !isEmpty else { return nil }
        let tailIndex = index(head + count - 1)
        return elements[tailIndex]
    }

    mutating func pushFront(_ element: Element) {
        if count == capacity {
            resize()
        }

        head = index(head - 1)
        elements[head] = element
        count += 1
    }

    mutating func pushBack(_ element: Element) {
        if count == capacity {
            resize()
        }

        let tailIndex = index(head + count)
        elements[tailIndex] = element
        count += 1
    }

    @discardableResult
    mutating func popFront() -> Element? {
        guard !isEmpty else { return nil }

        let element = elements[head]
        elements[head] = nil
        head = index(head + 1)
        count -= 1

        return element
    }

    @discardableResult
    mutating func popBack() -> Element? {
        guard !isEmpty else { return nil }

        let tailIndex = index(head + count - 1)
        let element = elements[tailIndex]
        elements[tailIndex] = nil
        count -= 1

        return element
    }

    private mutating func resize() {
        var newElements: [Element?] = Array(repeating: nil, count: capacity * 2)

        for i in 0..<count {
            newElements[i] = elements[index(head + i)]
        }

        elements = newElements
        head = 0
    }
}
