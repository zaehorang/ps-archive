//
//  42579.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 10/12/24.
//

// 🐯
func solution_42579(_ genres:[String], _ plays:[Int]) -> [Int] {
    var maxDict = [String: Int]()
    
    var playsDict = [String: [Int: Int]]()
    
    for (index, count) in plays.enumerated() {
        let key = genres[index]
        
        maxDict[key, default: 0] += count
        playsDict[key, default: [:]][index, default: 0] = count
    }
    
    var ans = [Int]()
    
    maxDict.sorted { $0.value > $1.value }.forEach {
        let key = $0.key
        
        
        //        if playsDict[key]?.count == 1 {
        //            ans.append(playsDict[key]!.first!.key)
        //        } else {
        let sortDict = playsDict[key]?.sorted {
            if $0.value == $1.value {
                return $0.key < $1.key
            } else {
                return $0.value > $1.value
            }
        }
        ans += sortDict!.prefix(2).map { $0.key }
        
        //            ans.append(sortDict!.first!.key)
        //            ans.append(sortDict![1].key)
        //        }
    }
    return ans
}
