//
//  main.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 4/6/24.
//  https://www.acmicpc.net/problem/1158


let input = readLine()!.split(separator: " ").map { Int($0)! }
let n = input[0]
let k = input[1]

var arr = Array(1...n)
var ans: [Int] = []

//MARK: - solve1 시간 초과
//var cnt = 0
//while !arr.isEmpty {
//    
//    for _ in 1...k {
//        arr.append(arr.removeFirst())
//    }
//    
//    ans.append(arr.removeLast())
//    
//}

//MARK: - solve2 큐 이용 => 메모리 초과
//https://velog.io/@comdongsam/Swift-%EB%B0%B1%EC%A4%80-1158-%EC%9A%94%EC%84%B8%ED%91%B8%EC%8A%A4-%EB%AC%B8%EC%A0%9C

//struct Queue {
//     var datas: [Int?] = []
//    private var head: Int = 0
//    
//    var count: Int {
//        datas.count - head
//    }
//    
//    var isEmpty: Bool {
//        count == 0
//    }
//    
//    mutating func enqueue(_ data: Int) {
//        datas.append(data)
//    }
//    
//    mutating func dequeue() -> Int? {
//        guard head < datas.count, let data = datas[head] else { return nil }
//        
//        datas[head] = nil
//        head += 1
//        
//        return data
//    }
//    
//}
//
//var q = Queue()
//for i in 1...n {
//    q.enqueue(i)
//}
//
//while !q.isEmpty {
//    for _ in 1...k-1 {
//        guard let data = q.dequeue() else { break }
//        q.enqueue(data)
//    }
//    
//    guard let data = q.dequeue() else { break }
//    ans.append(data)
//}

//MARK: - solve 3
var idx = 0

for _ in 1...n {
    idx = (idx + k - 1) % arr.count
    ans.append(arr.remove(at: idx))
}


print("<\(ans.map { String($0)}.joined(separator: ", "))>")


