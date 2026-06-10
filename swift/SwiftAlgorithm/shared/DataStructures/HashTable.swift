//
//  HashTable.swift
//  SwiftAlgorithm
//
//  Created by zaehorang on 6/10/26.
//

import Foundation

struct HashTable<Key: Hashable, Value> {
    private typealias Element = (key: Key, value: Value)

    private var buckets: [[Element]]
    private(set) var count: Int = 0

    init(capacity: Int = 16) {
        self.buckets = Array(repeating: [], count: capacity)
    }

    private func index(for key: Key) -> Int {
        abs(key.hashValue) % buckets.count
    }

    var loadFactor: Double {
        Double(count) / Double(buckets.count)
    }

    mutating func put(_ key: Key, _ value: Value) {
        if loadFactor > 0.75 {
            resize()
        }

        let index = index(for: key)

        for i in buckets[index].indices {
            if buckets[index][i].key == key {
                buckets[index][i].value = value
                return
            }
        }

        buckets[index].append((key, value))
        count += 1
    }

    func get(_ key: Key) -> Value? {
        let index = index(for: key)

        for element in buckets[index] {
            if element.key == key {
                return element.value
            }
        }

        return nil
    }

    @discardableResult
    mutating func remove(_ key: Key) -> Value? {
        let index = index(for: key)

        for i in buckets[index].indices {
            if buckets[index][i].key == key {
                let value = buckets[index][i].value
                buckets[index].remove(at: i)
                count -= 1
                return value
            }
        }

        return nil
    }

    private mutating func resize() {
        let oldBuckets = buckets
        buckets = Array(repeating: [], count: oldBuckets.count * 2)
        count = 0

        for bucket in oldBuckets {
            for element in bucket {
                put(element.key, element.value)
            }
        }
    }
}
