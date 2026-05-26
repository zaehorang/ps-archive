//
// 16943.swift
// Swift_Algorithm
//
// Created by zaehorang on 2026/3/26.
// https://acmicpc.net/problem/16943
//

import Foundation

func _16943() {
    // Your solution here
    let ab = readLine()!.split(separator: " ")
    let a = ab[0].map { String($0) }
    let b = Int(ab[1])!
    let count = a.count
    
    var isVisted: [Bool] = .init(repeating: false, count: a.count)
    var ans = -1
    
    func dfs(_ current: [String] = []) {
        if current.count == count
            && current[0] != "0" {
            
            let new = Int(current.joined(separator: ""))!
            guard new < b else { return }
            
            ans = max(ans, new)
            return
        }
        
        for i in 0..<count {
            guard !isVisted[i] else { continue }
            isVisted[i] = true
            dfs(current + [a[i]])
            isVisted[i] = false
        }
    }
    
    dfs()
    print(ans)
}


// Bit Masking
func _16943_1() {
    // Your solution here
    let ab = readLine()!.split(separator: " ")
    let a = ab[0].map { String($0) }
    let count = a.count
    
    let b = Int(ab[1])!
    
    
    let fullMask = (1 << count) - 1
    
    var ans = -1
    
    func dfs(_ mask: Int, _ current: String) {
        if mask == fullMask && current.first != "0" {
            if let c = Int(current), b > c {
                ans = max(ans, c)
            }
            return
        }
        
        for i in 0..<count {
            let newMask = (1 << i) | mask
            if mask == newMask { continue }
            
            dfs(newMask, current + a[i])
            
        }
    }
    
    dfs(0, "")
    print(ans)
}

// Backtracking + pruning
// Backtracking + pruning
func _16943_optimized() {
    let input = readLine()!.split(separator: " ")
    // 큰 숫자부터 먼저 써야, 처음 찾은 정답이 곧 최댓값이 된다.
    let digits = input[0].map { Int(String($0))! }.sorted(by: >)
    let bDigits = input[1].map { Int(String($0))! }

    let n = digits.count
    let m = bDigits.count

    // 자릿수가 B보다 많으면 어떤 경우에도 B보다 작은 수를 만들 수 없다.
    if n > m {
        print(-1)
        return
    }

    var used = Array(repeating: false, count: n)
    var answer = -1

    // depth: 현재 몇 자리까지 만들었는지
    // currentValue: 지금까지 만든 숫자
    // isLess:
    // - false: 지금까지 만든 앞부분이 B의 앞부분과 아직 같다.
    //          따라서 이번 자리에서 B의 같은 자리보다 큰 숫자는 놓을 수 없다.
    // - true:  앞부분에서 이미 B보다 작아졌다.
    //          따라서 뒤 자리는 자유롭게 골라도 항상 B보다 작다.
    func dfs(_ depth: Int, _ currentValue: Int, _ isLess: Bool) {
        // 모든 자리를 다 채웠으면 현재 값이 정답이다.
        if depth == n {
            answer = currentValue
            return
        }

        // 같은 depth에서 같은 숫자를 다시 시작점으로 쓰면
        // 중복 순열이 되므로 한 번만 사용한다.
        var previousDigit = -1

        for i in 0..<n {
            let digit = digits[i]

            if used[i] { continue }
            if previousDigit == digit { continue }
            // 맨 앞자리는 0이 될 수 없다.
            if depth == 0 && digit == 0 { continue }

            // 아직 앞부분이 B와 같은 상태라면,
            // 이번 자리에서 B의 같은 자리보다 큰 숫자는 놓을 수 없다.
            // 예: B가 321인데 첫 자리에 4를 놓으면 뒤를 볼 필요 없이 실패.
            if !isLess {
                if n == m {
                    let limit = bDigits[depth]
                    if digit > limit { continue }
                }
            }

            used[i] = true
            previousDigit = digit

            let nextIsLess: Bool
            if isLess || n < m {
                // 이미 앞에서 작아졌거나,
                // 애초에 자릿수가 B보다 짧으면 이후도 계속 작은 상태다.
                nextIsLess = true
            } else {
                // 아직 앞부분이 같았다면,
                // 이번 자리가 B의 같은 자리보다 작아지는 순간부터 true가 된다.
                // 예: B = 321, 현재 자리에서 2를 놓으면 이제 뒤는 무엇이 와도 전체는 321보다 작다.
                nextIsLess = digit < bDigits[depth]
            }

            dfs(depth + 1, currentValue * 10 + digit, nextIsLess)
            used[i] = false

            // 큰 숫자부터 시도하고 있으므로,
            // 처음 찾은 정답이 곧 최댓값이다. 더 볼 필요 없이 종료.
            if answer != -1 {
                return
            }
        }
    }

    dfs(0, 0, false)
    print(answer)
}
