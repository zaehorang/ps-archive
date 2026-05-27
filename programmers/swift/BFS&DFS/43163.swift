//
//  43163.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 10/5/24.
//  단어 변환

func solution_43163(_ begin:String, _ target:String, _ words:[String]) -> Int {
    
    var isUsed = [Bool](repeating: false, count: words.count)
    var ans = -1
    
    func canChange(_ a: String, _ b: String) -> Bool {
        var cnt = 0
        
        for i in 0..<a.count {
            if a[a.index(a.startIndex, offsetBy: i)] != b[b.index(b.startIndex, offsetBy: i)] {
                cnt += 1
            }
        }
        
//        ❗️ 위의 for문과 같은 로직
//        for (index, element) in a.enumerated() {
//            if element == b[b.index(b.startIndex, offsetBy: index)] {
//                cnt += 1
//            }
//        }
        
        return cnt == 1 ? true : false
    }
    
    func recursion(n: Int, str: String) {
        if str == target {
            if ans != -1 {
                ans = min(ans, n)
                return
            }
            ans = n
            return
        }
        
        for i in 0..<words.count {
            if !isUsed[i] && canChange(str, words[i]) {
                isUsed[i] = true
                recursion(n: n + 1, str: words[i])
                isUsed[i] = false
            }
        }
    }
    
    recursion(n: 0, str: begin)
    
    return ans == -1 ? 0 : ans
}

