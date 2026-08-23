//
//  main.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 4/7/24.
//  https://www.acmicpc.net/problem/1874

//MARK: - input
var n = Int(readLine()!)!

//MARK: - solve
var s = [Int]()
var ans = [Character]()

var i = 1
var canCal = true

while n > 0 && canCal {
    let a = Int(readLine()!)!
    
    while true {
        
        if i <= a {
            s.append(i)
            ans.append("+")
            
            if i == a {
                let _ = s.popLast()
                ans.append("-")
                i += 1
                break
            }
            i += 1
        } else if i > a {
            // 굳이?????????????????????????
            // 꼭 필요한가요?
            guard let pop = s.popLast() else {
                canCal = false
                break
            }
            ans.append("-")
            
            if a == pop {
                break
            }
            
        }
        
    }
    
    n -= 1
}

//MARK: - output
if canCal {
    ans.forEach {
        print($0)
    }
} else {
    print("NO")
}
