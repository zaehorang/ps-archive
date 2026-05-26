//
//  2961.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 12/23/25.
//  https://www.acmicpc.net/problem/2961

import Foundation

func _2961() {
    let N = Int(readLine()!)!
    var ingredients: [[Int]] = []
    
    for _ in 0..<N {
        let ingredient = readLine()!.split(separator: " ").map { Int($0)! }
        ingredients.append(ingredient)
    }
    
    var bestFlavor = Int.max
    
    for i in 1..<(1 << N) {
        var bitter = 0
        var sour = 1
        
        for j in 0..<N {
            if 1 == ((i >> j) & 1) {
                let ingredient = ingredients[j]
                sour *= ingredient[0]
                bitter += ingredient[1]
            }
        }
        
        let flavor = abs(bitter - sour)
        
        if bestFlavor > flavor { bestFlavor = flavor }
    }
    
    print(bestFlavor)
}

func _2961_1() {
    let N = Int(readLine()!)!
    var ingredients: [[Int]] = []
    
    for _ in 0..<N {
        let ingredient = readLine()!.split(separator: " ").map { Int($0)! }
        ingredients.append(ingredient)
    }
    
    var bestFlavor = Int.max
    
    func recursion(_ n: Int, bitter: Int, sour: Int, isAdded: Bool) {
        if n == N {
            if isAdded {
                let flavor = abs(bitter - sour)
                bestFlavor = min(flavor, bestFlavor)
            }
            return
        }
        
        // 선택
        recursion(n + 1,
                  bitter: bitter + ingredients[n][1],
                  sour: sour * ingredients[n][0],
                  isAdded: true
        )
        
        // 미선택
        recursion(n + 1, bitter: bitter, sour: sour, isAdded: isAdded)
    }
    
    recursion(0, bitter: 0, sour: 1, isAdded: false)
    print(bestFlavor)
}
