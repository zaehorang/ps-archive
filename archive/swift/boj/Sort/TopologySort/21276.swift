//
//  21276.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 11/24/25.
//

import Foundation

func _21276() {
    let _ = Int(readLine()!)!
    let names = readLine()!.split(separator: " ").map { String($0) }
    
    let M = Int(readLine()!)!
    
    var graph: [String: [String]] = .init()
    var indegrees: [String: Int] = .init()
    var ans: [String: [String]] = .init()
    
    names.forEach {
        graph[$0] = []
        indegrees[$0] = 0
        
        ans[$0] = []
    }
    
    for _ in 0..<M {
        let ab = readLine()!.split(separator: " ").map { String($0) }
        let (a, b) = (ab[0], ab[1])
        
        graph[b, default: []].append(a)
        indegrees[a, default: 0] += 1
    }
    
    var queue = [String]()
    
    for (name, count) in indegrees where count == 0 {
        queue.append(name)
    }
    
    queue.sort()
    print(queue.count)
    print(queue.joined(separator: " "))
    
    
    
    while !queue.isEmpty {
        let top = queue.removeFirst()
        
        graph[top, default: []].forEach {
            indegrees[$0, default: 0] -= 1
            
            if indegrees[$0, default: 0] == 0 {
                queue.append($0)
                ans[top, default: []].append($0)
            }
        }
    }
    
    for key in ans.keys.sorted() {
        var str = ""
        
        str += "\(key) "
        str += "\(ans[key, default: []].count) "
        str += "\(ans[key, default: []].sorted().joined(separator: " "))"
        
        print(str)
    }
}


/// Index Mapping
/// Coordinate Comporession을 이용해서 배열의 인덱스로 이름들 처리하기
/// (+) 현재는 queue를 의미상으로 네이밍만 해서 사용하고 있지만 진짜 queue는 아님. shifting 문제 있음.
/// 수정하면 더 빠르게 동작 가능
func _21276_others() {
    let N = Int(readLine()!)!
    let namesInput = readLine()!.split(separator: " ").map { String($0) }
    
    // 정렬된 이름 배열과 name -> index 매핑 생성
    let sortedNames = namesInput.sorted()
    var nameToIndex: [String: Int] = .init()
    sortedNames.enumerated().forEach { nameToIndex[$1] = $0 }
    
    let M = Int(readLine()!)!
    
    var graph: [[Int]] = .init(repeating: [], count: N)
    var indegrees: [Int] = .init(repeating: 0, count: N)
    var ans: [[Int]] = .init(repeating: [], count: N)
    
    for _ in 0..<M {
        let ab = readLine()!.split(separator: " ").map { String($0) }
        let (a, b) = (ab[0], ab[1])
        
        guard let ai = nameToIndex[a],
              let bi = nameToIndex[b]
        else { continue }
        
        graph[bi].append(ai)
        indegrees[ai] += 1
    }
    
    // 진입 차수가 0인 정점(조상)을 큐에 넣기
    var queue = [Int]()
    
    for i in 0..<N {
        if indegrees[i] == 0 {
            queue.append(i)
        }
    }
    
    // sortedNames 기준으로 인덱스를 만들었기 때문에 이미 사전순
    let rootsNames = queue.map { sortedNames[$0] }
    print(rootsNames.count)
    print(rootsNames.joined(separator: " "))
    
    // 위상 정렬 진행하면서 직계 자손 관계(ans)에 기록
    while !queue.isEmpty {
        let cur = queue.removeFirst()
        
        for child in graph[cur] {
            indegrees[child] -= 1
            if indegrees[child] == 0 {
                queue.append(child)
                ans[cur].append(child)
            }
        }
    }
    
    // 각 사람에 대해: 이름, 직계 자손 수, 직계 자손 이름(사전순)을 출력
    for i in 0..<N {
        let children = ans[i]
        let sortedChildrenNames = children
            .sorted()
            .map { sortedNames[$0] }
        
        if sortedChildrenNames.isEmpty {
            print("\(sortedNames[i]) 0")
        } else {
            print("\(sortedNames[i]) \(sortedChildrenNames.count) \(sortedChildrenNames.joined(separator: " "))")
        }
    }
}
