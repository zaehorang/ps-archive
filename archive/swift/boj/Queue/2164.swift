//
//  main.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 4/9/24.
//  https://www.acmicpc.net/problem/2164

struct Q {
    private var q = [Int]()
    
    private var firstIndex = 0
    
    var isEmpty: Bool {
        q.count == firstIndex
    }
    
    var size: Int {
        q.count - firstIndex
    }
    
    var first: Int {
        q[firstIndex]
    }
    
    mutating func enqueue(_ n: Int) {
        q.append(n)
    }
    
//    @discardableResult
// 이거 쓰면 더 오래 걸림
    mutating func dequeue() -> Int? {
        guard !self.isEmpty else { return nil }
        let n = q[firstIndex]
        q[firstIndex] = 0
        firstIndex += 1
        return n
    }
}

//MARK: - input
let n = Int(readLine()!)!

//MARK: - solve
var q = Q()

for a in 1 ... n {
    q.enqueue(a)
}

// 두 개 이하로 남기기
while q.size > 2 {
    let _ = q.dequeue()
    q.enqueue(q.dequeue()!)
}


//MARK: - output
if q.size == 1 {  // n이 1일수도 있음
    print(1)
} else {
    let _ = q.dequeue()
    print(q.dequeue()!)
}

