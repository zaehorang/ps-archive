//
// 16906.swift
// Swift_Algorithm
//
// Created by zaehorang on 2026/2/1.
// https://acmicpc.net/problem/16906
//

import Foundation

/*
[풀이 고민 흔적 / 접근 방향 정리]

- 처음 아이디어:
  * 길이가 긴 것부터 트라이에 넣기
  * 0 우선으로 내려가고, 막히면 1 시도
  * 둘 다 막히면 한 단계 위로 백트래킹해서 1로 전환 (이 과정을 반복)
  → “가장 왼쪽 leaf부터 채우는” 느낌으로 코드워드를 만들려고 했음

- 그런데 긴 것부터가 구현/증명 면에서 까다로운 이유:
  * 짧은 길이 코드워드는 ‘어떤 prefix 노드를 terminal로 확정’하는 행위이고,
    그 순간 그 아래 서브트리는 통째로 사용 불가(prefix-free 때문에).
  * 긴 코드워드를 먼저 여기저기(여러 prefix 구역) 박아두면,
    나중에 짧은 길이 prefix를 terminal로 하고 싶을 때
    그 prefix 아래에 이미 누군가가 들어가 있어서 terminal을 못 박는 상황이 생길 수 있음.
  * 이 경우 단순히 “현재 길이에서만” 백트래킹으로는 해결이 안 되고,
    이미 만든 긴 코드워드들의 위치 자체를 옮기는 전역 재배치가 필요해질 수 있음.

- 그래서 선택한 정석 흐름(현재 구현):
  * 길이 오름차순(짧은 것부터)으로 처리
  * 짧은 코드를 먼저 check로 확정해서 아래 서브트리를 봉인
  * 이후 긴 코드는 남은 leaf만 DFS(0→1)로 찾으면 되므로 구현이 안정적

- 구현 규칙(DFS):
  * check[node] == true(terminal)이면 더 내려가면 기존 단어가 prefix가 되므로 탐색 금지
  * remaining == 0이면 그 노드를 terminal로 확정(check[node] = true)
  * 0부터, 실패하면 1로 내려가며 자식이 없으면 생성
*/

func _16906() {
    // Your solution here
    let _ = Int(readLine()!)!
    
    let pairs = readLine()!
        .split(separator: " ")
        .compactMap { Int($0) }
        .enumerated()
        .sorted { $0.1 < $1.1 } // 크기 순 정렬 (실제 위치는 보존)
    
    let ROOT = 1
    let MAX = 1000 * 1000 + 5
    
    var unused = 2
    
    var nxt: [[Int]] = .init(repeating: [-1, -1], count: MAX)
    var check: [Bool] = .init(repeating: false, count: MAX)

    var ans: [String] = .init(repeating: "", count: pairs.count)
    
    for (idx, len) in pairs {
        var path: [Character] = []
        
        func dfs(_ cur: Int, _ remaining: Int) -> Bool {
            if check[cur] { return false }
            if remaining == 0 {
                check[cur] = true
                return true
            }
            
            for bit in 0...1 {
                var next = nxt[cur][bit]
                if next == -1 {
                    nxt[cur][bit] = unused
                    next = unused
                    unused += 1
                }
                
                path.append(bit == 0 ? "0" : "1")
                if dfs(next, remaining - 1) { return true }
                path.removeLast()
            }
            
            return false
        }
        
        if dfs(ROOT, len) {
            ans[idx] = String(path)
        } else {
            print(-1)
            return
        }
    }
    
    print(1)
    for str in ans {
        print(str)
    }
}
