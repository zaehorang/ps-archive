//
// 17835.swift
// Swift_Algorithm
//
// Created by zaehorang on 2026/1/18.
// https://acmicpc.net/problem/17835
//

import Foundation

/*
 [내가 처음에 생각했던 지점 (여기까지는 맞았음)]
 1) 목표는 각 도시 i에서 “가장 가까운 면접장”까지의 최단거리.
 2) 면접장 K개 각각에 대해 i -> 면접장 최단거리를 구하면,
 결국 i마다 min 값을 취하면 된다.
 3) 이때 방향 때문에 “도시 -> 면접장”을 직접 다루기 불편하니,
 간선을 뒤집어서 “면접장에서 출발”하는 형태로 바꾸면 편해진다.
 (원래 u -> v 를 v -> u로 저장)
 
 [내가 하려던 방식 (시간초과로 이어질 수 있었던 부분)]
 - “같은 dist 배열을 계속 업데이트하면 전체 최소가 누적될 것”이라고 생각했고,
 그래서 면접장 하나씩 시작점으로 다익스트라를 여러 번 돌리면서
 dist를 갱신하는 방식(= K번 다익스트라)을 떠올렸다.
 
 [내가 놓쳤던 핵심 1: Multi-source Dijkstra]
 - 사실 “면접장 여러 개”는 K번 다익스트라가 아니라,
 시작점을 K개로 두고 다익스트라를 ‘한 번’만 돌리면 된다.
 즉,
 dist[면접장]=0 으로 전부 초기화하고,
 heap에 면접장을 전부 push한 뒤,
 일반 다익스트라처럼 진행하면
 한 번의 실행으로 모든 도시의 “가장 가까운 면접장까지 거리”가 완성된다.
 
 [내가 놓쳤던 핵심 2: 시간 복잡도 관점의 위험]
 - K번 다익스트라:  K * (M log N)  → K가 크면 사실상 불가능
 - Multi-source 1번: (M log N)      → 통과 가능
 
 [결론]
 - 간선 뒤집기까지는 정확히 잡았고,
 - “시작점을 한 번에 넣는 multi-source”를 떠올리지 못한 게 시간초과의 본질이었다.
 - 해결: 뒤집은 그래프 + 면접장 전부를 시작점으로 한 번만 다익스트라.
 */

func _17835() {
    // Your solution here
    final class FileIO {
        private var data: [UInt8] = Array(FileHandle.standardInput.readDataToEndOfFile()) + [0]
        private var idx: Int = 0
        
        @inline(__always)
        private func skipWhitespace() {
            while data[idx] == 10 || data[idx] == 13 || data[idx] == 32 {
                idx += 1
            }
        }
        
        @inline(__always)
        func readInt() -> Int {
            skipWhitespace()
            var sign = 1
            var num = 0
            
            if data[idx] == 45 { // '-'
                sign = -1
                idx += 1
            }
            
            while data[idx] >= 48 {
                num = num * 10 + Int(data[idx] - 48)
                idx += 1
            }
            return num * sign
        }
    }
    
    typealias Dist = (c: Int, s: Int)
    
    struct MinHeap {
        private var table: [Dist] = [(0, 0)]
        private var count = 0
        var isEmpty: Bool { count == 0 }
        
        private var areSorted: (Dist, Dist) -> Bool = {
            $0.c < $1.c
        }
        
        mutating func push(_ n: Dist) {
            table.append(n)
            count += 1
            
            var index = count
            
            while index != 1 {
                let parentIdx = index / 2
                if areSorted(table[parentIdx], table[index]) { break }
                
                table.swapAt(index, parentIdx)
                index = parentIdx
            }
        }
        
        mutating func pop() -> Dist {
            let min = table[1]
            table[1] = table[count]
            table.removeLast()
            count -= 1
            
            var index = 1
            
            while index * 2 <= count {
                let leftChildIdx = index * 2
                let rightChildIdx = index * 2 + 1
                
                var targetChildIdx = leftChildIdx
                
                if rightChildIdx <= count,
                   areSorted(table[rightChildIdx], table[leftChildIdx]) {
                    targetChildIdx = rightChildIdx
                }
                
                if areSorted(table[index], table[targetChildIdx]) {
                    break
                }
                
                table.swapAt(index, targetChildIdx)
                index = targetChildIdx
            }
            
            return min
        }
    }
    
    let file = FileIO()
    
    let n = file.readInt()
    let m = file.readInt()
    let k = file.readInt()
    
    var table: [[Dist]] = .init(repeating:[], count: n + 1)
    for _ in 0..<m {
        let u = file.readInt()
        let v = file.readInt()
        let c = file.readInt()
        
        table[v].append((c, u))
    }
    
    let INF = Int.max / 4
    
    func dijkstra(_ starts: [Int]) -> [Int] {
        var dist: [Int] = .init(repeating: INF, count: n + 1)
        
        var heap = MinHeap()
        for start in starts {
            dist[start] = 0
            heap.push((0, start))
        }
        
        while !heap.isEmpty {
            let current = heap.pop()
            guard current.c == dist[current.s] else { continue }
            
            for new in table[current.s] {
                let nc = current.c + new.c
                if nc < dist[new.s] {
                    dist[new.s] = nc
                    heap.push((nc, new.s))
                }
            }
        }
        return dist
    }
    
    var destinations: [Int] = []
    for _ in 0..<k {
        destinations.append(file.readInt())
    }
    
    var bestIndex = 0
    var bestCost = 0
    
    let finalDist = dijkstra(destinations)
    
    for index in 1...n {
        if bestCost < finalDist[index] {
            bestCost = finalDist[index]
            bestIndex = index
        }
    }
    print("\(bestIndex)\n\(bestCost)")
}
