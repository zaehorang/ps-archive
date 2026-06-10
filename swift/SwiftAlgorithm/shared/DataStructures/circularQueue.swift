//
//  circularQueue.swift
//  SwiftAlgorithm
//
//  Created by zaehorang on 6/10/26.
//

import Foundation

enum QueueError: Error {
    case full
    case empty
}

final class CircularQueue {
    private let maxCount: Int
    private var buffer: [Int?]

    // readIndex: dequeue/front 위치
    // writeIndex: 다음 enqueue 위치
    private var readIndex: Int = 0
    private var writeIndex: Int = 0
    private var elementCount: Int = 0

    init(maxSize: Int) {
        precondition(maxSize > 0, "maxSize must be greater than 0")
        self.maxCount = maxSize
        self.buffer = Array(repeating: nil, count: maxSize)
    }

    func enqueue(_ value: Int) throws {
        guard !isFull() else {
            throw QueueError.full
        }

        buffer[writeIndex] = value
        writeIndex = (writeIndex + 1) % maxCount
        elementCount += 1
    }

    func dequeue() throws -> Int {
        guard !isEmpty() else {
            throw QueueError.empty
        }

        let value = buffer[readIndex]!
        buffer[readIndex] = nil

        readIndex = (readIndex + 1) % maxCount
        elementCount -= 1

        return value
    }

    func front() throws -> Int {
        guard !isEmpty() else {
            throw QueueError.empty
        }

        return buffer[readIndex]!
    }

    func isEmpty() -> Bool {
        elementCount == 0
    }

    func isFull() -> Bool {
        elementCount == maxCount
    }

    func size() -> Int {
        elementCount
    }

    func maxSize() -> Int {
        maxCount
    }
}
