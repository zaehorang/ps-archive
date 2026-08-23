//
// 9202.swift
// Swift_Algorithm
//
// Created by zaehorang on 2026/1/31.
// https://acmicpc.net/problem/9202
//

import Foundation

/// 시간초과
func _9202() {
    // Your solution here
    let w = Int(readLine()!)!
    var dict: [[Character]] = []
    for _ in 0..<w {
        dict.append(Array(readLine()!))
    }
    let _ = readLine()
    
    
    
    let dx = [0, 1, 1, 1, 0, -1, -1, -1]
    let dy = [1, 1, 0, -1, -1, -1, 0, 1]
    
    func solution(_ boggle: [[Character]]) -> String {
        var find: [[Character]] = []
        
        for t in dict {
            var starts: [(Int, Int)] = []
            
            // 시작점 찾기
            for x in 0..<4 {
                for y in 0..<4 {
                    if t[0] == boggle[x][y] {
                        starts.append((x, y))
                    }
                }
            }
            
            func recursion(
                _ start: (Int, Int),
                _ isVisted: [[Bool]],
                _ count: Int
            ) -> Bool {
                
                guard count < t.count else { return true }
                
                for i in 0..<dx.count {
                    let nx = start.0 + dx[i]
                    let ny = start.1 + dy[i]
                    
                    guard nx < 4 && nx >= 0 else { continue }
                    guard ny < 4 && ny >= 0 else { continue }
                    guard !isVisted[nx][ny] else { continue }
                    
                    if boggle[nx][ny] == t[count] {
                        var newIsVisted = isVisted
                        newIsVisted[nx][ny] = true
                        
                        if !recursion((nx, ny), newIsVisted, count + 1) {
                            continue
                        } else {
                            return true
                        }
                    }
                }
                
                return false
            }
            
            for start in starts {
                var isVisted: [[Bool]] = .init(repeating: .init(repeating: false, count: 4), count: 4)
                isVisted[start.0][start.1] = true
                
                if recursion(start, isVisted, 1) {
                    find.append(t)
                    break
                }
            }
        }
        
        find.sort {
            if $0.count > $1.count {
                return true
            } else if $0.count == $1.count {
                return String($0) < String($1)
            }
            return false
        }
        
        var points = 0
        
        for t in find {
            let count = t.count
            if count >= 8 {
                points += 11
            } else if count == 7 {
                points += 5
            } else if count == 6 {
                points += 3
            } else if count == 5 {
                points += 2
            } else if count >= 3 {
                points += 1
            }
        }
        
        return "\(points) \(String(find[0])) \(find.count)"
    }
    
    let b = Int(readLine()!)!
    var ans = ""
    
    for i in 0..<b {
        var boggle = [[Character]]()
        for _ in 0..<4 {
            boggle.append(Array(readLine()!))
        }
        
        /// solution
        ans += "\(solution(boggle))\n"
        if i < b - 1 {
            let _ = readLine()
        }
    }
    print(ans)
}


// ✅ 시간초과 해결 아이디어 ( _9202  →  _9202_1 로 전환 )
//
// 기존(_9202):
// - 사전의 모든 단어(W개)를 하나씩 꺼내서, 보드에서 만들 수 있는지 DFS로 확인
// - W가 매우 크기 때문에(최대 수십만), 보드 1장마다 "단어 수만큼" 탐색이 반복되어 시간초과
// - 게다가 DFS 중 visited 배열 복사 등이 겹치면 더 느려짐
//
// 개선(_9202_1): "기준을 반대로" 바꿈
// - 보드에서 DFS를 돌며 '만들 수 있는 경로'만 따라가고, 그 경로가 사전에 존재 가능한지 빠르게 판정
// - 이때 사전은 Trie(접두사 트리)로 미리 구성
//
// Trie를 쓰는 이유:
// - DFS로 글자를 한 칸 더 확장할 때마다, Trie에서 다음 글자로 내려갈 수 있는지 확인
// - 만약 nxt[cur][nextChar] == -1 이면
//   → 이 prefix로 시작하는 단어가 사전에 없다는 뜻
//   → 더 내려가도 절대 단어가 될 수 없으니 즉시 가지치기(pruning)
// - 즉, "의미 없는 경로"를 초반에 잘라내서 탐색량을 크게 줄임
//
// 보드 처리 흐름:
// 1) 사전 단어들을 배열 Trie(nxt)로 저장하고, 단어 끝 노드에는 (길이, 단어 문자열)을 저장(check)
// 2) 각 보드에 대해 16칸에서 DFS 시작
// 3) DFS 중 현재 Trie 노드가 단어 끝이면(findSet에 추가)
// 4) 모든 DFS가 끝나면 findSet으로 점수 합/가장 긴 단어(동률이면 사전순)/개수 출력
func _9202_1() {
    // Your solution here
    let MAX = 300000 * 8 + 5
    let ROOT = 1
    var unused = 2
    
    var nxt: [[Int]] = .init(repeating: .init(repeating: -1, count: 26), count: MAX)
    var check: [(Int, String)] = .init(repeating: (0, ""), count: MAX)
    
    func c2i(_  char: Character) -> Int {
        return Int(char.asciiValue! - Character("A").asciiValue!)
    }
    
    let w = Int(readLine()!)!
    
    for _ in 0..<w {
        let s = readLine()!
        let str = Array(s)
        var cur = ROOT
        
        for char in str {
            let cIdx = c2i(char)
            if nxt[cur][cIdx] == -1 {
                nxt[cur][cIdx] = unused
                unused += 1
            }
            cur = nxt[cur][cIdx]
        }
        check[cur] = (str.count, s)
    }
    
    let _ = readLine()!
    
    var ans = ""
    
    let scoreByLen = [0, 0, 0, 1, 1, 2, 3, 5, 11]
    
    let dx = [0, 1, 1, 1, 0, -1, -1, -1]
    let dy = [1, 1, 0, -1, -1, -1, 0, 1]
    
    let b = Int(readLine()!)!
    for i in 0..<b {
        var boggle = [[Character]]()
        for _ in 0..<4 { boggle.append(Array(readLine()!)) }
        
        var findSet: Set<String> = []
        
        func dfs(_ x: Int, _ y: Int, _ cur: Int, _ isVisted: [[Bool]]) {
            if check[cur].0 > 0 { findSet.insert(check[cur].1) }
            
            for i in 0..<dx.count {
                let nx = x + dx[i]
                let ny = y + dy[i]
                
                guard nx >= 0, nx < 4 else { continue }
                guard ny >= 0, ny < 4 else { continue }
                guard !isVisted[nx][ny] else { continue }
                
                let nIdx = c2i(boggle[nx][ny])
                if nxt[cur][nIdx] == -1 { continue }
                
                var copyVisted = isVisted
                copyVisted[nx][ny] = true
                
                dfs(nx, ny, nxt[cur][nIdx], copyVisted)
            }
        }
        
        for x in 0..<4 {
            for y in 0..<4 {
                let idx = c2i(boggle[x][y])
                if nxt[ROOT][idx] == -1 { continue }
                var isVisted: [[Bool]] = .init(repeating: .init(repeating: false, count: 4), count: 4)
                isVisted[x][y] = true
                
                dfs(x, y, nxt[ROOT][idx], isVisted)
            }
        }
        if i < b - 1 { let _ = readLine()! }

        var totalScore = 0
        var bestStr = ""
        var maxCount = 0
        
        for str in findSet {
            let count = str.count
            totalScore += scoreByLen[count]
            
            if maxCount < count {
                maxCount = count
                bestStr = str
            } else if maxCount == count {
                bestStr = min(bestStr, str)
            }
        }
        
        ans += "\(totalScore) \(bestStr) \(findSet.count)\n"
    }
    print(ans)
}

func _9202_2() {
    // _9202_1과 아이디어는 동일 (Trie + 보드 DFS + prefix 가지치기)
    // 다만 DFS에서 반복되는 "비싼 작업"을 줄이기 위해 아래 최적화를 적용했다.
    // - visited 배열을 매번 복사하지 않고, 1개 배열을 backtracking(왔다갔다)으로 사용
    // - findSet(Set<String>) 대신 stamp 배열로 "이번 보드에서 이미 찾은 단어"를 O(1)로 중복 제거
    // - 단어를 발견하는 순간(score / best / count)을 즉시 갱신해서 후처리 루프 제거
    // - 보드를 16칸짜리 [UInt8] (A~Z -> 0~25)로 저장해 인덱싱을 빠르게
    // - 16칸 각각의 이웃칸 목록(neighbors)을 미리 계산해 범위체크 반복 제거

    let MAX = 300000 * 8 + 5
    let ROOT = 1
    var unused = 2

    // nxt[node][ch] = node에서 문자 ch(0~25)로 이동했을 때의 다음 노드 (없으면 -1)
    // check[node] = (길이, 단어). 길이가 0이면 단어 끝이 아님.
    var nxt: [[Int]] = .init(repeating: .init(repeating: -1, count: 26), count: MAX)
    var check: [(Int, String)] = .init(repeating: (0, ""), count: MAX) // (length, word)

    @inline(__always)
    func c2i(_ char: Character) -> Int {
        Int(char.asciiValue! - Character("A").asciiValue!)
    }

    // 1) 사전 단어들을 Trie에 넣는다.
    //    여기서 Trie를 만드는 이유는 DFS 중 prefix가 사전에 존재 가능한지 빠르게 가지치기하기 위해서다.
    let w = Int(readLine()!)!
    for _ in 0..<w {
        let s = readLine()!
        let str = Array(s)
        var cur = ROOT

        for ch in str {
            let cIdx = c2i(ch)
            if nxt[cur][cIdx] == -1 {
                nxt[cur][cIdx] = unused
                unused += 1
            }
            cur = nxt[cur][cIdx]
        }
        check[cur] = (str.count, s)
    }

    // 입력 포맷상 사전 뒤에 빈 줄이 한 줄 들어올 수 있다.
    // readLine() 한 번 소비해서 보드 개수 입력과 정렬을 맞춘다.
    _ = readLine()

    // 2) neighbors 미리 계산(precompute)
    // pos = x*4 + y (0~15) 라고 두고, neighbors[pos]에 8방향으로 갈 수 있는 유효한 pos들만 저장한다.
    // DFS에서는 매번 dx/dy + 범위체크를 하지 않고, neighbors[pos]만 순회하면 된다.
    var neighbors: [[Int]] = Array(repeating: [], count: 16)
    for x in 0..<4 {
        for y in 0..<4 {
            let id = x * 4 + y
            var list: [Int] = []
            list.reserveCapacity(8)
            for dx in -1...1 {
                for dy in -1...1 {
                    if dx == 0 && dy == 0 { continue }
                    let nx = x + dx
                    let ny = y + dy
                    if (0..<4).contains(nx), (0..<4).contains(ny) {
                        list.append(nx * 4 + ny)
                    }
                }
            }
            neighbors[id] = list
        }
    }

    let scoreByLen = [0, 0, 0, 1, 1, 2, 3, 5, 11]

    // 3) 중복 제거 (stamp 방식)
    // 같은 단어(= 같은 terminal node)를 여러 경로로 찾을 수 있으므로, 보드마다 1번만 카운트해야 한다.
    // foundStamp[node] == stamp 이면 "이번 보드에서 이미 처리한 단어".
    // 보드가 바뀔 때 stamp를 +1만 하면 배열 전체 초기화가 필요 없다.
    var foundStamp: [Int] = .init(repeating: 0, count: MAX)
    var stamp = 0

    let b = Int(readLine()!)!
    var ans = ""

    for boardIndex in 0..<b {
        // 보드를 16칸짜리 1차원 배열로 저장한다.
        // board[pos] = 0..25 (A..Z) 로 변환해두면 Trie 인덱싱(nxt[node][ch])이 빨라진다.
        var board: [UInt8] = Array(repeating: 0, count: 16)
        for row in 0..<4 {
            let line = readLine()!
            var col = 0
            for byte in line.utf8 {
                board[row * 4 + col] = byte &- 65
                col += 1
                if col == 4 { break }
            }
        }

        // 입력에 따라 보드와 보드 사이에 빈 줄이 있을 수 있다.
        if boardIndex < b - 1 { _ = readLine() }

        stamp += 1

        var totalScore = 0
        var bestStr = ""
        var bestLen = 0
        var foundCount = 0

        // visited backtracking
        var visited: [Bool] = Array(repeating: false, count: 16)

        // 현재 Trie 노드가 "단어 끝"이라면 결과에 반영한다.
        // - stamp로 중복 제거
        // - 점수 누적
        // - bestStr 갱신(길이 우선, 길이 같으면 사전순)
        @inline(__always)
        func tryAccept(_ node: Int) {
            let (len, word) = check[node]
            if len == 0 { return }
            if foundStamp[node] == stamp { return }
            foundStamp[node] = stamp

            foundCount += 1
            totalScore += scoreByLen[len]

            if len > bestLen {
                bestLen = len
                bestStr = word
            } else if len == bestLen {
                if bestStr.isEmpty || word < bestStr {
                    bestStr = word
                }
            }
        }

        // DFS(pos, node, depth)
        // - pos: 현재 보드 칸(0~15)
        // - node: 현재 Trie 노드
        // - depth: 현재까지 만든 단어 길이
        // 가지치기 핵심: next == -1이면 이 prefix로 시작하는 단어가 없으므로 더 내려갈 필요가 없다.
        // visited는 1개 배열을 true/false로 되돌리는 backtracking 방식으로 사용한다.
        func dfs(pos: Int, node: Int, depth: Int) {
            // 단어 끝이면 즉시 누적
            tryAccept(node)
            if depth == 8 { return }

            visited[pos] = true
            for np in neighbors[pos] {
                if visited[np] { continue }
                let ch = Int(board[np])
                let next = nxt[node][ch]
                if next == -1 { continue } // 가지치기
                dfs(pos: np, node: next, depth: depth + 1)
            }
            visited[pos] = false
        }

        // 16칸 모두를 시작점으로 DFS를 시작한다.
        // 단, ROOT에서 해당 문자로 갈 수 없는 경우(first == -1)는 시작 자체를 생략한다.
        for start in 0..<16 {
            let ch = Int(board[start])
            let first = nxt[ROOT][ch]
            if first == -1 { continue }
            dfs(pos: start, node: first, depth: 1)
        }

        ans += "\(totalScore) \(bestStr) \(foundCount)\n"
    }

    print(ans)
}
