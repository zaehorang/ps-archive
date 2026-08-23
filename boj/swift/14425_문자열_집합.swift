//
// 14425.swift
// Swift_Algorithm
//
// Created by zaehorang on 2026/1/27.
// https://acmicpc.net/problem/14425
//

import Foundation

func _14425() {
    // Your solution here
    let nm = readLine()!.split(separator: " ").compactMap { Int($0) }
    let (n, m) = (nm[0], nm[1])
    
    var set: Set<String> = []
    for _ in 0..<n {
        set.insert(readLine()!)
    }
    
    var ans = 0
    for _ in 0..<m {
        let str = readLine()!
        ans += set.contains(str) ? 1 : 0
    }
    print(ans)
}

// MARK: - Trie
/*
BOJ 14425 Trie 구현에서 "코드 형태"에 따라 성능이 갈리는 이유 (Swift 특성)

[세 가지 형태]
1) Trie를 struct로 만들고 mutating 메서드(insert/find)로 처리
2) solve() 함수 안에서 nxt/chk/unused를 지역 변수로 만들고,
   insert/find를 "중첩 함수"로 정의해서 바깥 지역 변수를 사용
3) main.swift(top-level)에서 전역/탑레벨 변수 + 전역 함수로 바로 처리

[왜 3번이 가장 유리한가]
- 2번의 중첩 함수는 바깥 지역 변수(nxt/chk/unused)를 참조하면
  Swift 컴파일러가 이를 "클로저 캡처"로 판단할 수 있음.
  -> 로컬 변수들을 스택이 아닌 힙의 'box'에 올리는 capture boxing이 발생 가능
  -> 매 접근마다 box를 경유(간접 접근)하게 되어 아주 작은 오버헤드가
     문자 수(최대 수백만~천만) 만큼 누적되어 TLE로 이어질 수 있음.
  (SIL에서 alloc_box / project_box 같은 패턴이 보이면 캡처 박싱 가능성이 큼)

- 1번(struct)은 "캡처"가 핵심 원인은 아님.
  대신 nxt가 [[Int]](배열의 배열)일 때 nxt[cur][c] = ... 같은 중첩 subscript 수정이
  내부적으로 row 배열을 꺼내서 수정 후 다시 넣는 형태로 풀릴 수 있고,
  이 과정에서 Copy-on-Write(유니크 체크/복사)와 임시 row 생성이 반복되면 비용이 커짐.
  -> 같은 로직이라도 코드 형태에 따라 컴파일러 최적화(인라이닝/CoW 제거)가
     덜 먹으면 TLE 가능성이 올라감.

- 3번(전역/탑레벨)은 캡처가 원천적으로 없고 접근 경로가 단순해서
  컴파일러 인라이닝/최적화가 더 잘 적용되는 편이라 통과 가능성이 높아짐.

[결론]
- Swift에서는 "알고리즘이 같아도" (특히 Array/[[Int]]/String 처리에서)
  코드 형태(전역 vs 지역 중첩 함수 vs struct 메서드)에 따라
  캡처 박싱 여부, CoW 경로, 인라이닝 적용 여부가 달라져 성능이 갈릴 수 있다.
*/

/// 시간 초과
func _14425_trie1() {
    struct Trie {
        let ROOT = 1
        var unused = 2
        let MAX: Int
        var chx: [Bool]
        var nxt: [[Int]]
        
        init(max: Int, count: Int) {
            self.MAX = max
            self.chx = .init(repeating: false, count: MAX)
            
            self.nxt = .init(repeating: .init(repeating: -1, count: 26), count: max)
        }
        
        func c2i(_ char: Character) -> Int {
            Int(char.asciiValue! - Character("a").asciiValue!)
        }
        
        mutating func insert(_ str: String) {
            var cur = ROOT
            for char in str {
                let cIdx = c2i(char)
                if nxt[cur][cIdx] == -1 {
                    nxt[cur][cIdx] = unused
                    unused += 1
                }
                cur = nxt[cur][cIdx]
            }
            chx[cur] = true
        }
        
        func find(_ str: String) -> Bool {
            var cur = ROOT
            for char in str {
                let cIdx = c2i(char)
                if nxt[cur][cIdx] == -1 { return false }
                cur = nxt[cur][cIdx]
            }
            return chx[cur]
        }
        
        mutating func erase(_ str: String) {
            var cur = ROOT
            for char in str {
                let cIdx = c2i(char)
                if nxt[cur][cIdx] == -1 { return }
                cur = nxt[cur][cIdx]
            }
            chx[cur] = false
        }
        
    }
    
    let nm = readLine()!.split(separator: " ").compactMap { Int($0) }
    let (n, m) = (nm[0], nm[1])
    
    var trie = Trie(max: 10000 * 500 + 5, count: 26)
    
    for _ in 0..<n {
        trie.insert(readLine()!)
    }
    
    var ans = 0
    for _ in 0..<m { if trie.find(readLine()!) { ans += 1 } }
    
    print(ans)
}

// 시간초과
func _14425_trie2() {
    let ROOT = 1
    var unused = 2
    let MAX = 10000 * 500 + 5
    var chx: [Bool] = .init(repeating: false, count: MAX)
    var nxt: [[Int]] = .init(repeating: .init(repeating: -1, count: 26), count: MAX)

    func c2i(_ char: Character) -> Int {
        Int(char.asciiValue! - Character("a").asciiValue!)
    }

    func insert(_ str: String) {
        var cur = ROOT
        for char in str {
            let cIdx = c2i(char)
            if nxt[cur][cIdx] == -1 {
                nxt[cur][cIdx] = unused
                unused += 1
            }
            cur = nxt[cur][cIdx]
        }
        chx[cur] = true
    }

    func find(_ str: String) -> Bool {
        var cur = ROOT
        for char in str {
            let cIdx = c2i(char)
            if nxt[cur][cIdx] == -1 { return false }
            cur = nxt[cur][cIdx]
        }
        return chx[cur]
    }

    let nm = readLine()!.split(separator: " ").compactMap { Int($0) }
    let (n, m) = (nm[0], nm[1])

    for _ in 0..<n {
        insert(readLine()!)
    }
    var ans = 0
    for _ in 0..<m { if find(readLine()!) { ans += 1 } }

    print(ans)
}

/*
 메서드 내부에서 실행말고 전역으로 풀어서 제출해야 시간 내 통과 가능
 */
func _14425_trie3() {
    let ROOT = 1
    var unused = 2
    let MAX = 10000 * 500 + 5
    var chx: [Bool] = .init(repeating: false, count: MAX)
    var nxt: [[Int]] = .init(repeating: .init(repeating: -1, count: 26), count: MAX)

    func c2i(_ char: Character) -> Int {
        Int(char.asciiValue! - Character("a").asciiValue!)
    }

    func insert(_ str: String) {
        var cur = ROOT
        for char in str {
            let cIdx = c2i(char)
            if nxt[cur][cIdx] == -1 {
                nxt[cur][cIdx] = unused
                unused += 1
            }
            cur = nxt[cur][cIdx]
        }
        chx[cur] = true
    }

    func find(_ str: String) -> Bool {
        var cur = ROOT
        for char in str {
            let cIdx = c2i(char)
            if nxt[cur][cIdx] == -1 { return false }
            cur = nxt[cur][cIdx]
        }
        return chx[cur]
    }

    let nm = readLine()!.split(separator: " ").compactMap { Int($0) }
    let (n, m) = (nm[0], nm[1])

    for _ in 0..<n {
        insert(readLine()!)
    }
    var ans = 0
    for _ in 0..<m { if find(readLine()!) { ans += 1 } }

    print(ans)
}
