//
//  LRUCache.swift
//  SwiftAlgorithm
//
//  Created by zaehorang on 6/10/26.
//

import Foundation

final class LRUCache {
    private final class Node {
        var key: Int
        var value: Int
        var prev: Node?
        var next: Node?

        init(_ key: Int, _ value: Int) {
            self.key = key
            self.value = value
        }
    }

    private let capacity: Int
    private var cache: [Int: Node] = [:]

    private let head = Node(0, 0)
    private let tail = Node(0, 0)

    init(_ capacity: Int) {
        self.capacity = capacity
        head.next = tail
        tail.prev = head
    }

    func get(_ key: Int) -> Int {
        guard let node = cache[key] else {
            return -1
        }

        moveToFront(node)
        return node.value
    }

    func put(_ key: Int, _ value: Int) {
        if let node = cache[key] {
            node.value = value
            moveToFront(node)
            return
        }

        let newNode = Node(key, value)
        cache[key] = newNode
        addToFront(newNode)

        if cache.count > capacity {
            let lruNode = removeLast()
            cache[lruNode.key] = nil
        }
    }

    private func moveToFront(_ node: Node) {
        remove(node)
        addToFront(node)
    }

    private func addToFront(_ node: Node) {
        let first = head.next!

        node.prev = head
        node.next = first

        head.next = node
        first.prev = node
    }

    private func remove(_ node: Node) {
        let prev = node.prev!
        let next = node.next!

        prev.next = next
        next.prev = prev
    }

    private func removeLast() -> Node {
        let last = tail.prev!
        remove(last)
        return last
    }
}
