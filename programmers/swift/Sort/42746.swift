//
//  42746.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 10/4/24.
//

// ❌ 시간 초과 이슈 + 인덱스 에러 이슈(아마?)
// numbers는 100,000이하
func solution1_42746(_ numbers:[Int]) -> String {

    var isUsed = [Bool](repeating: false, count: numbers.count)
    var arr = [Int]()
    
    var numString = [String](repeating: "", count: numbers.count)
    
    func permutation(k: Int) {
        if k == numbers.count {
            var a = ""
            numString.forEach { a += $0 }
            arr.append(Int(a)!)
            return
        }
        
        for i in 0..<numbers.count {
            if !isUsed[i] {
                numString[k] = String(numbers[i])
                isUsed[i] = true
                permutation(k: k + 1)
                isUsed[i] = false
            }
        }
    }
    
    permutation(k: 0)
    arr.sort(by: >)
    return String(arr[0])
}

// 혼자 못 풀고 도움 받았음..⭐️⭐️⭐️⭐️⭐️
func solution_42746(_ numbers:[Int]) -> String {
    let numStringArr = numbers.map{ String($0) }.sorted {
        $0 + $1 > $1 + $0
    }
    
    return numStringArr[0] == "0" ? "0" : numStringArr.joined()
}
