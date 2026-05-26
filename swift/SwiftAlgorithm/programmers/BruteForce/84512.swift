//
//  84512.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 10/7/24.
//  모음사전
//  https://school.programmers.co.kr/learn/courses/30/lessons/84512

// 현재는 답을 찾아도 끝까지 다 돌아가는 로직
//  ❗️답을 찾으면 로직을 종료할 수 있도록 수정해보기. (불가능..?)
// 다른 사람들은 dictionary에 모든 값을 넣어두고 마지막에 해당 값을 찾아서 답을 구한다.
// 해당 방식보다는 내 방식이 공간 복잡도에서는 더 좋다고 생각
func solution_84512(_ word:String) -> Int {
    let alphabets = ["A", "E", "I", "O", "U"]
    
    var cnt = 0
    var myString = ""
    var findAnswer = false
    
    func recurtion(k: Int) {
        if word == myString {
            findAnswer = true
            return
        }
        
        if k == alphabets.count {
            return
        }
        
        for i in 0..<alphabets.count {
            myString += alphabets[i]
            if !findAnswer {
                cnt += 1
            }
            recurtion(k: k + 1)
            myString.removeLast()
        }
    }
    recurtion(k: 0)
    return cnt
}
