//
// 13549.swift
// Swift_Algorithm
//
// Created by zaehorang on 2026/2/27.
// https://acmicpc.net/problem/13549
//

import Foundation

// (참고) 최초 시도/아이디어 보관용: 스택 기반 역탐색
// - 최단거리 보장은 어려워서 실제 제출은 _13549_1(0-1 BFS) 또는 _13549_2(다익스트라)를 사용
func _13549() {
    // Your solution here
        let nk = readLine()!.split(separator: " ").compactMap { Int($0) }
        let n = nk[0], k = nk[1]
        
        guard n < k else {
            print(n-k)
            return
        }
        
        var stack: [(Int, Int)] = [(k, 0)]
        var minTimes: [Int] = .init(repeating: 100005, count: k + 5)
        
        while !stack.isEmpty {
            let top = stack.removeLast()
            
            guard top.0 >= 0 && top.0 <= k else { continue }
            guard minTimes[top.0] > top.1 else { continue }
            minTimes[top.0] = top.1
            print(top.0)
            if top.0 == n {
                print(top.1)
                return
            }
            
            stack.append((top.0 / 2, top.1))
            stack.insert((top.0 - 1, top.1 + 1), at: 0)
            stack.insert((top.0 + 1, top.1 + 1), at: 0)
        }
}

func _13549_1() {
    // BOJ 13549: 숨바꼭질 3
    // 핵심: 간선 가중치가 0(순간이동) / 1(걷기)로 섞여있어 일반 BFS/DFS로는 최단거리 보장이 안 됨
    // => 0-1 BFS (Deque 사용)로 dist(최소 시간)를 갱신하면서 처리한다.

    let nk = readLine()!.split(separator: " ").compactMap { Int($0) }
    let n = nk[0], k = nk[1]

    // n이 k 이상이면 순간이동(×2)은 도움이 되지 않고 -1로만 내려가면 됨
    if n >= k {
        print(n - k)
        return
    }

    let maxPos = 100000
    var dist = Array(repeating: Int.max, count: maxPos + 1)

    // 덱(Deque) 구현: head/tail 인덱스로 앞/뒤 삽입/삭제
    // Swift Array에서 insert(at:0) / removeFirst()는 O(n)이라 시간/런타임 문제가 날 수 있음
    var deque = Array(repeating: 0, count: (maxPos + 1) * 2 + 5)
    var head = maxPos + 1
    var tail = head

    @inline(__always) func pushFront(_ x: Int) {
        head -= 1
        deque[head] = x
    }

    @inline(__always) func pushBack(_ x: Int) {
        deque[tail] = x
        tail += 1
    }

    @inline(__always) func popFront() -> Int {
        let x = deque[head]
        head += 1
        return x
    }

    // 시작점
    dist[n] = 0
    pushFront(n)

    while head < tail {
        let cur = popFront()
        let t = dist[cur]

        // 목표에 도달하면 현재 시간이 최단시간
        if cur == k {
            print(t)
            return
        }

        // 0초 이동: 순간이동 cur -> cur*2
        // 비용이 0이므로 덱의 앞에 넣어 "더 빨리" 처리되게 한다.
        let teleport = cur * 2
        if teleport <= maxPos && dist[teleport] > t {
            dist[teleport] = t
            pushFront(teleport)
        }

        // 1초 이동: cur -> cur-1
        // 비용이 1이므로 덱의 뒤에 넣는다.
        let left = cur - 1
        if left >= 0 && dist[left] > t + 1 {
            dist[left] = t + 1
            pushBack(left)
        }

        // 1초 이동: cur -> cur+1
        let right = cur + 1
        if right <= maxPos && dist[right] > t + 1 {
            dist[right] = t + 1
            pushBack(right)
        }
    }
}

func _13549_2() {
    // BOJ 13549: 숨바꼭질 3 (Dijkstra 버전)
    // 0-1 BFS로도 풀리지만, 가중치가 음수가 없고 (0/1) 이므로 다익스트라도 정답.

    let nk = readLine()!.split(separator: " ").compactMap { Int($0) }
    let n = nk[0], k = nk[1]

    // n이 k 이상이면 -1로만 가는 게 최단
    if n >= k {
        print(n - k)
        return
    }

    let maxPos = 100000
    var dist = Array(repeating: Int.max, count: maxPos + 1)

    // (거리, 정점) 최소 힙 - 튜플 기반
    struct MinHeap {
        // 1-based index heap (heap[0] is a dummy)
        private var heap: [(Int, Int)] = [(0, 0)]
        private var size: Int = 0

        // 거리 우선, 거리 같으면 정점 번호 우선
        private let areSorted: ((Int, Int), (Int, Int)) -> Bool = { a, b in
            if a.0 != b.0 { return a.0 < b.0 }
            return a.1 < b.1
        }

        var isEmpty: Bool { size == 0 }

        mutating func push(_ elem: (Int, Int)) {
            size += 1
            heap.append(elem)

            var index = size
            while index > 1 {
                let parent = index / 2
                if areSorted(heap[parent], heap[index]) { break }
                heap.swapAt(parent, index)
                index = parent
            }
        }

        mutating func pop() -> (Int, Int) {
            let minElem = heap[1]
            heap[1] = heap[size]
            heap.removeLast()
            size -= 1

            var index = 1
            while index * 2 <= size {
                let left = index * 2
                let right = left + 1

                var target = left
                if right <= size && areSorted(heap[right], heap[left]) {
                    target = right
                }

                if areSorted(heap[index], heap[target]) { break }
                heap.swapAt(index, target)
                index = target
            }

            return minElem
        }
    }

    var heap = MinHeap()
    dist[n] = 0
    heap.push((0, n))

    while !heap.isEmpty {
        let (d, cur) = heap.pop()
        if d != dist[cur] { continue } // 더 좋은 경로가 이미 있으면 스킵

        if cur == k {
            print(d)
            return
        }

        // 순간이동: 비용 0
        let teleport = cur * 2
        if teleport <= maxPos {
            let nd = d
            if nd < dist[teleport] {
                dist[teleport] = nd
                heap.push((nd, teleport))
            }
        }

        // 걷기: 비용 1 (cur - 1)
        let left = cur - 1
        if left >= 0 {
            let nd = d + 1
            if nd < dist[left] {
                dist[left] = nd
                heap.push((nd, left))
            }
        }

        // 걷기: 비용 1 (cur + 1)
        let right = cur + 1
        if right <= maxPos {
            let nd = d + 1
            if nd < dist[right] {
                dist[right] = nd
                heap.push((nd, right))
            }
        }
    }
}
