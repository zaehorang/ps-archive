//
//  86971.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 10/6/24.
//  전력망을 둘로 나누기
//  https://school.programmers.co.kr/learn/courses/30/lessons/86971

// 🐯 풀이
func solution_86971(_ n:Int, _ wires:[[Int]]) -> Int {
    /*
     1. 모든 전선을 한 번씩 끊어서 아래 과정을 체킹한다.
     2. 첫번째 전선을 방문하고 표시한다.
     3. 방문한 연결 전선을 빼고 앞에서 부터 계속 체킹
     - 이전에 연결되어 있어서 방문할 수 있는지
     - 이전에 방문했던 연결은 아닌지
     4. 위에 과정을 계속 돌다가 전선 배열을 다 돌고 난 뒤에 방문한 곳과 아닌 곳의 값의 차이를 구한다.
     */
    if wires.count == 1 { return 0 }
    
    func bfs(brokenIndex: Int) -> Int {
        // 처음 방문 표시
        var isFirst = true
        // 방문한 전선 표시
        var isVisitedWire = [Bool](repeating: false, count: n + 1)
        // 방문한 배열의 인덱스 표시
        var isVisitedIndex = [Bool](repeating: false, count: n - 1)
        
        for i in 0..<(n - 1) where brokenIndex != i {
            let (a, b) = (wires[i][0], wires[i][1])
            
            if isFirst { // 처음은 무조건 방문
                isVisitedWire[a] = true
                isVisitedWire[b] = true
                
                isVisitedIndex[i] = true
                
                isFirst = false
            }
            
            for j in 0..<(n - 1) where brokenIndex != j {
                // 이전에 방문한 곳이면 continue
                if isVisitedIndex[j] { continue }
                
                // 연결이 안되어 있으면 continue
                let (m, n) = (wires[j][0], wires[j][1])
                if !isVisitedWire[m] && !isVisitedWire[n] { continue }
                
                // 연결되어 있는 곳이면 방문 표시
                isVisitedIndex[j] = true
                
                isVisitedWire[m] = true
                isVisitedWire[n] = true
            }
        }
        
        var visitedCnt = 0
        isVisitedWire.forEach { if $0 { visitedCnt += 1 } }
        
        let notVisitedcnt = abs(n - visitedCnt)
        
        return abs(visitedCnt - notVisitedcnt)
    }
    
    var ans = [Int]()
    
    for broken in 0..<(n - 1) {
        ans.append(bfs(brokenIndex: broken))
    }
    
    return ans.min()!
}


// 참고 풀이
func solution1_86971(_ n:Int, _ wires:[[Int]]) -> Int {
    var graph = [Int: [Int]]()
    for i in 1...n {
        graph.updateValue([], forKey: i)
    }
    
    for wire in wires {
        graph[wire[0]]?.append(wire[1])
        graph[wire[1]]?.append(wire[0])
    }
    
    var visited = [Bool](repeating: false, count: n + 1)
    
    // 무조건 1번부터 시작
    func bfs() -> Int {
        if visited[1] { return 101 } // 1번 연결이 처음부터 끊어지면 종료
        
        var queue = [1]
        visited[1] = true
        
        var count = 0
        
        while !queue.isEmpty {
            let now = queue.removeFirst()
            count += 1
            
            for i in graph[now]! {
                if !visited[i] {
                    queue.append(i)
                    visited[i] = true
                }
            }
        }
        return count
    }
    
    var ans = 101
    
    for i in 1...n {
        visited = [Bool](repeating: false, count: n + 1)
        // 끊기
        // wires를 트리로 그려서 방문 표시를 해보면 이해 가능❗️
        visited[i] = true
        
        let cnt = bfs()
        
        ans = min(ans, abs(cnt - (n - cnt)))
    }
    return ans
}
