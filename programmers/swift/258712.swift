//
//  258712.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 10/9/24.
//  2024 KAKAO WINTER INTERSHIP 가장 많이 받은 선물
//  https://school.programmers.co.kr/learn/courses/30/lessons/258712

func solution_258712(_ friends:[String], _ gifts:[String]) -> Int {
    var dict: [String: [String: Int]] = [:]
    
    // Make dictionary
    for a in friends {
        dict[a] = [:]
        
        for b in friends {
            dict[a]?[b] = 0
        }
    }
    
    // Count gift
    gifts.forEach {
        let gift = $0.split(separator: " ").map { String($0) }
        let (give, get) = (gift[0], gift[1])
        
        dict[give]?[get]! += 1
    }
    
    var giftIndex = [String: [String: Int]]()
    
    for a in friends {
        giftIndex[a] = ["give": 0, "get": 0]
    }
    
    for (give, getArray) in dict {
        for (key, val) in getArray {
            giftIndex[give]?["give"]! += val
            giftIndex[key]?["get"]! += val
        }
    }
    
    // 인덱스 계산
    for (key, array) in giftIndex {
        giftIndex[key]?["index"] = array["give"]! - array["get"]!
        
    }
    
    // 몇개 선물을 받을까
    var ans = [String: Int]()
    for friend in friends {
        ans[friend] = 0
    }
    
    for a in friends {
        for b in friends {
            if a == b { continue }
            
            if (dict[a]?[b])! > (dict[b]?[a])! { // 더 많이 주면
                ans[a]! += 1
            } else if (dict[a]?[b])! == (dict[b]?[a]){ // 같으면
                if (giftIndex[a]?["index"])! > (giftIndex[b]?["index"])! {
                    ans[a]! += 1
                }
            }
        }
    }
    print(dict)
    print(ans)
    return ans.values.max()!
}


// 리팩토링 + 다른 사람 코드 참고
func solution1_258712(_ friends:[String], _ gifts:[String]) -> Int {
    // 딕셔너리 대신 인덱스로 쉽게 접근하기 위해 배열로 변경
    // (+) 선물 지수를 한 번에 표시하기 위해 count + 1
    var table = Array(repeating: [Int](repeating: 0, count: friends.count + 1), count: friends.count)
    
    var index = [String: Int]()
    
    for (idx, name) in friends.enumerated() {
        index[name] = idx
    }
    
    
    gifts.forEach {
        let gift = $0.split(separator: " ").map { String($0) }
        let give = index[gift[0]]!
        let get = index[gift[1]]!
        
        table[give][get] += 1
        
        // Count gife index
        table[give][friends.count] += 1
        table[get][friends.count] -= 1
    }
    
    // ⭐️ 신기방귀
    // friend로 인덱스를 살리고, partialResult로 이전 max값과 현재 count를 비교해서 값을 가져간다.
    return friends.reduce(0) { partialResult, friend in
        let i = index[friend]!
        
        var count = 0
        
        for j in 0..<friends.count {
            if i == j { continue }
            
            if table[i][j] > table[j][i] {
                count += 1
            }
            else if table[i][j] == table[j][i] && table[i][friends.count] > table[j][friends.count] {
                count += 1
            }
        }
        return max(partialResult, count)
    }
}
