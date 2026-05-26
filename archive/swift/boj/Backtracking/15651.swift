//
//  15651.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 7/1/24.
//  https://www.acmicpc.net/problem/15651
//  N과 M (3)

func _15651() {
    let nm = readLine()!.split(separator: " ").map { Int($0)! }
    let n = nm[0]
    let m = nm[1]
    
    var arr: [Int] = .init(repeating: 0, count: m)
    var ans = [String]()
    
    recursion(k: 0)
    ans.forEach { print($0) }
    
    func recursion(k: Int) {
        if k == m {
            // 기존 백트래킹 문제에서는 해당 분기에서 프린트를 해주었는데,
            // 해당 문제에서는 시간초과 문제로 답을 저장한 뒤에, 한 번에 출력을 해주었음
            // 이렇게하면 print문이 절반으로 줄어서 더 효율적일 듯? (줄바꿈 프린트를 해주지 않아도 되기 때문..?)
            
            // 🐯 뭐가 더 빠를까 ??
//            var num = ""
//            arr.forEach { num += (String($0) + " ")}
//            ans.append(num)
            
            let num = arr.map { String($0) }.joined(separator: " ")
            ans.append(num)
            return
        }
        
        for i in 1...n {
                arr[k] = i
                recursion(k: k + 1)
        }
    }
}
