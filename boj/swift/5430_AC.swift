//
//  main.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 4/15/24.
//  https://www.acmicpc.net/problem/5430

//MARK: - 5430: AC
var t = Int(readLine()!)!

//MARK: - solve
// 배열 Index

while t > 0 {
    var head = 0
    var tail = 0
    var indexSave = 0
    
    var isReversed = false
    var canCal = true
    
    let p = readLine()!
    let _ = Int(readLine()!)!
    
    // , 이 없으면 빈 배열 ???
    let arr = readLine()!.dropLast().dropFirst().split(separator: ",").map { Int($0)! }
    
    
    if !arr.isEmpty {
        tail = arr.count - 1
    } else {
        tail = 0
    }
    
    for a in p {
        if a == "R" {  // reverse
            // exchange
            indexSave = tail
            tail = head
            head = indexSave
            
            isReversed.toggle()
            
        } else { // "D" delete
            
            if head != tail {
                
                if isReversed {
                    head -= 1
                    
                } else if !isReversed {
                    head += 1
                }
                
                
            } else {  // tail == head -> 빈 배열
                canCal = false
                break
            }
            
        }
    }
    
    //MARK: - output
    if canCal {
        if tail == head && arr.isEmpty {
            print("[]")
        } else if tail == head {
            print(arr)
        } else {
            if isReversed {
                let ans = Array(arr[tail...head].reversed())
                let last = ans.count - 1
                
                
                print("[", terminator: "")
                
                for i in 0..<last {
                    print(ans[i], terminator: ",")
                }
                print(ans[last], terminator: "]\n")
                
            } else {
                
                let ans = Array(arr[head...tail])
                let last = ans.count - 1
                
                print("[", terminator: "")
                
                for i in 0..<last {
                    print(ans[i], terminator: ",")
                }
                print(ans[last], terminator: "]\n")
            }
        }
        
    } else {
        print("error")
    }
    
    t -= 1
    
}

