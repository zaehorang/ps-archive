//
// 1086.swift
// Swift_Algorithm
//
// Created by zaehorang on 2026/3/25.
// https://acmicpc.net/problem/1086
//

import Foundation

func _1086() {
    // Your solution here
    let n = Int(readLine()!)!
    let total = 1 << n
    
    var arr: [String] = []
    
    for _ in 0..<n { arr.append(readLine()!) }
    let num = Int(readLine()!)!
    
    var count = 0
    var isVisted: [Bool] = .init(repeating: false, count: n)
    
    func dfs(_ str: String) {
        if let strN = Int(str) {
            if strN % num == 0 { count += 1}
        }
        
        for i in 0..<arr.count {
            guard !isVisted[i] else { continue }
            let new = str + arr[i]
            isVisted[i] = true
            dfs(new)
            isVisted[i] = false
            
            
        }
        
    }
    
    dfs("")
    print(count)
}

func _1086_1() {
    // 숫자 개수
    let n = Int(readLine()!)!
    
    // 숫자는 길이가 매우 길 수 있어서 String으로 받는다.
    var numbers: [String] = []
    for _ in 0..<n {
        numbers.append(readLine()!)
    }
    
    // 나눌 기준 K
    let k = Int(readLine()!)!
    
    // 모든 숫자를 다 사용한 상태
    // 예: n = 4 -> 1111(2)
    let fullMask = (1 << n) - 1
    
    // 각 숫자의 길이
    var lengths = [Int](repeating: 0, count: n)
    
    // numbers[i] 자체를 k로 나눈 나머지
    var numberMods = [Int](repeating: 0, count: n)
    
    // numbers[i]를 뒤에 붙일 때 앞 숫자에 곱해야 하는 값
    // = 10^(numbers[i].count) % k
    var moveValues = [Int](repeating: 0, count: n)
    
    // 10^length % k 계산
    func tenPowerMod(_ length: Int) -> Int {
        var result = 1 % k
        for _ in 0..<length {
            result = (result * 10) % k
        }
        return result
    }
    
    // 미리 필요한 값 계산
    for i in 0..<n {
        let current = numbers[i]
        lengths[i] = current.count
        moveValues[i] = tenPowerMod(lengths[i])
        
        var remainder = 0
        for ch in current {
            remainder = (remainder * 10 + Int(String(ch))!) % k
        }
        numberMods[i] = remainder
    }
    
    // memo[mask][remainder]
    // = 현재 mask 상태이고, 지금까지 만든 수의 나머지가 remainder일 때
    //   끝까지 완성하는 경우의 수
    var memo = Array(
        repeating: Array(repeating: Int64(-1), count: k),
        count: 1 << n
    )
    
    func dfs(_ mask: Int, _ remainder: Int) -> Int64 {
        // 모든 숫자를 다 쓴 경우
        if mask == fullMask {
            return remainder == 0 ? 1 : 0
        }
        
        // 이미 계산한 상태면 재사용
        if memo[mask][remainder] != -1 {
            return memo[mask][remainder]
        }
        
        var result: Int64 = 0
        
        // 아직 안 쓴 숫자를 하나 골라 뒤에 붙인다.
        for i in 0..<n {
            if (mask & (1 << i)) != 0 { continue }
            
            let nextMask = mask | (1 << i)
            
            // 현재 숫자 뒤에 numbers[i]를 붙였을 때의 새 나머지
            // (기존 나머지 * 10^(붙일 숫자 길이) + 붙일 숫자 자체의 나머지) % k
            let nextRemainder = (remainder * moveValues[i] + numberMods[i]) % k
            
            result += dfs(nextMask, nextRemainder)
        }
        
        memo[mask][remainder] = result
        return result
    }
    
    // 시작: 아무 숫자도 안 쓴 상태, 현재 나머지 0
    let numerator = dfs(0, 0)
    
    // 전체 경우의 수 = n!
    var denominator: Int64 = 1
    if n >= 2 {
        for i in 2...n {
            denominator *= Int64(i)
        }
    }
    
    func gcd(_ a: Int64, _ b: Int64) -> Int64 {
        var x = a
        var y = b
        
        while y != 0 {
            let temp = x % y
            x = y
            y = temp
        }
        
        return x
    }
    
    let g = gcd(numerator, denominator)
    print("\(numerator / g)/\(denominator / g)")
}
