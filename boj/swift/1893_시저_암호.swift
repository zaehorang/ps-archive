//
// 1893.swift
// Swift_Algorithm
//
// Created by zaehorang on 2026/1/23.
// https://acmicpc.net/problem/1893
//

/*
 [BOJ 1893] 시저 암호 (KMP)

 핵심 아이디어
 - 알파벳 A의 길이 m = |A| ≤ 62 이므로, 가능한 시프트(0..m-1)를 전부 검사해도 된다.
 - 각 시프트마다 패턴 W를 A 기준으로 시프트한 W_k 를 만들고,
   텍스트 S 안에서 W_k 가 등장하는 횟수를 KMP로 세어 “정확히 1번”인 시프트만 정답으로 채택한다.
 - 단순 비교로는 O(N·L) 이라 비효율적이므로, KMP로 매칭을 선형 시간으로 처리한다.

 기호 / 최대 범위
 - m = |A| ≤ 62
 - L = |W| ≤ 50,000 (= 5×10^4)
 - N = |S| ≤ 500,000 (= 5×10^5)

 시프트 1회당 작업
 1) W_k 생성: O(L)
 2) 실패함수(π, failure) 생성: O(L)
 3) KMP로 S에서 W_k 등장 횟수 계산: O(N)
    - 2회 이상 등장하면 더 볼 필요가 없으므로 즉시 중단(break)

 전체 시간복잡도 (테스트 케이스 1개)
 - O(m · (N + L))

 최악 연산량(대략적인 규모)
 - m·N = 62 · 5×10^5 = 3.1×10^7  (≈ 10^7 규모, 약 3천만)
 - m·L = 62 · 5×10^4 = 3.1×10^6  (≈ 10^6 규모, 약 3백만)
 - 합산하면 대략 3.4×10^7 수준(≈ 10^7 ~ 10^8 사이, 수천만 단위)
   ※ 실제 KMP는 mismatch 처리까지 포함하면 비교/대입이 더 늘 수 있지만, 여전히 “수천만 단위” 범위로 봄.

 메모
 - KMP failure 생성은 패턴 길이 L에 대해 O(L)
 - KMP 검색은 텍스트 길이 N에 대해 O(N)
 */

func _1893() {
    // Your solution here
    func failure(_ arr: [Character]) -> [Int] {
        var failure: [Int] = .init(repeating: 0 , count: arr.count)
        var j = 0
        
        for i in 1..<arr.count {
            while j > 0 && arr[i] != arr[j] { j = failure[j - 1]}
            if arr[j] == arr[i] {
                j += 1
                failure[i] = j
            }
        }
        return failure
    }
    
    let n = Int(readLine()!)!
    var ans = ""
    
    for _ in 0..<n {
        let a = Array(readLine()!)
        var aKey: [Character: Int] = [:]
        for val in (0..<a.count) {
            aKey[a[val], default: val] = val
        }
        
        let w = Array(readLine()!)
        let s = Array(readLine()!)
        
        var shifts: [Int] = []
        
        for shift in 0..<a.count {
            var nw: [Character] = []
            for char in w {
                let nIdx = (aKey[char]! + shift) % a.count
                nw.append(a[nIdx])
            }
            
            var j = 0
            let nwf = failure(nw)
            var existCount = 0
            
            for i in 0..<s.count {
                while j > 0 && s[i] != nw[j] { j = nwf[j - 1] }
                if s[i] == nw[j] { j += 1 }
                
                if j == nw.count {
                    existCount += 1
                    if existCount > 1 { break }
                    j = nwf[j - 1]
                }
            }
            if existCount == 1 { shifts.append(shift) }
        }
        
        if shifts.isEmpty {
            ans += "no solution\n"
        } else if shifts.count == 1 {
            ans += "unique: \(shifts.first!)\n"
        } else {
            ans += "ambiguous: \(shifts.map {String($0) }.joined(separator: " "))\n"
        }
    }
    
    print(ans)
}
