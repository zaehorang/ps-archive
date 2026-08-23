//
// 12851.swift
// Swift_Algorithm
//
// Created by zaehorang on 2026/2/28.
// https://acmicpc.net/problem/12851
//

import Foundation

func _12851() {
    let nk = readLine()!.split(separator: " ").compactMap { Int($0) }
    let (n, k) = (nk[0], nk[1])

    // n >= k 인 경우는 -1만 반복하는 게 최단(다른 연산은 거리를 줄이지 못함)
    if n >= k {
        print(n - k)
        print(1)
        return
    }

    let MAX = 100000

    // dist[x] = x까지의 최단 시간 (미방문 = -1)
    // ways[x] = dist[x]로 x에 도달하는 방법의 수
    var dist = Array(repeating: -1, count: MAX + 1)
    var ways = Array(repeating: 0, count: MAX + 1)

    // O(1) pop을 위한 인덱스 큐
    var queue: [Int] = [n]
    var head = 0

    dist[n] = 0
    ways[n] = 1

    while head < queue.count {
        let cur = queue[head]
        head += 1

        let nextCandidates = [cur - 1, cur + 1, cur * 2]
        for next in nextCandidates {
            guard next >= 0 && next <= MAX else { continue }

            // 처음 방문: 최단거리 확정 + 방법 수 전달
            if dist[next] == -1 {
                dist[next] = dist[cur] + 1
                ways[next] = ways[cur]
                queue.append(next)
            } else if dist[next] == dist[cur] + 1 {
                // 이미 최단거리로 방문한 적이 있는데, 같은 최단거리로 또 도달 가능하면 방법 수 누적
                ways[next] += ways[cur]
            }
        }
    }

    print(dist[k])
    print(ways[k])
}
