//
//  UnionFind.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 12/15/25.
//

import Foundation

struct UnionFind {
    private var arr: [Int]
    private var count: Int
    
    init(count: Int) {
        self.count = count
        self.arr = .init(repeating: -1, count: count + 1)
    }
    
    /// b 그룹을 a 그룹으로 합친다.
    mutating func union(_ a: Int, _ b: Int) -> Bool {
        let rootA = find(a)
        let rootB = find(b)
        
        // 이미 union이 되어 있음
        guard rootA != rootB else { return false }
        
        // b의 root를 a의 root랑 연결
        arr[rootB] = rootA
        return true
    }
    
    // MARK: - Find 최악의 경우(일자 트리) O(N)
    
    /// 반복문 방식
    func find(_ a: Int) -> Int {
        var copyA = a
        
        while arr[copyA] > 0 {
            copyA = arr[copyA]
        }
        return copyA
    }
    
    /// 재귀 방식
    func find_recursion(_ a: Int) -> Int {
        if arr[a] < 0 { return a }
        
        return find_recursion(arr[a])
    }
    
    // MARK: - Optimization version
    
    /// (1) Union by rank  - O(log N)
    mutating func unionByRank(_ a: Int, _ b: Int) -> Bool {
        var rootA = find(a)
        var rootB = find(b)
        
        if rootA == rootB { return false }
        
        // rootB의 랭크가 더 큰 경우 rootA가 더 큰 상태로 변경
        // 랭크는 -로 표현되기 때문에 실제 계산에서는 더 작은게 랭크가 큰 것
        if arr[rootA] > arr[rootB] { swap(&rootA, &rootB) }
        
        if arr[rootA] == arr[rootB] { arr[rootA] -= 1 }
        
        arr[rootB] = rootA
        return true
    }
    
    /// (2) path comporession - Amortized O(log N)
    mutating func find_other(_ a: Int) -> Int {
        if arr[a] < 0 { return a }
        arr[a] = find_other(arr[a])
        
        return arr[a]
    }
    
    /*
     (1)과 (2)를 같이 쓰면 "사실상" 상수 시간
     -> unionByRank 함수에 find를 수정
     
     But, (1)과 2() 같이 적용하게 되면 (2)로 인해 (1)의 Rank는 Tree의 Height와는 개념이 달라진다..!
     height 개념이라면 높이가 줄어들게 되면서 rank도 수정을 해줘야 한다.
     하지만 해당 Route가 Root 정점에 경로라고는 단정할 수 없음.
     
     */
}
