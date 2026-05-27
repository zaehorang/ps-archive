//
//  42748.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 10/4/24.
//

func solution(_ array:[Int], _ commands:[[Int]]) -> [Int] {
    var ans = [Int]()
    
    func findK(i: Int, j: Int, k: Int) -> Int {
        var arr = [Int]()
        for idx in (i-1)...(j-1) {
            arr.append(array[idx])
        }
        return arr.sorted()[k-1]
    }
    
    for arr in commands {
        ans.append(findK(i: arr[0], j: arr[1], k: arr[2]))
    }
    return ans
}

func solution2(_ array:[Int], _ commands:[[Int]]) -> [Int] {
    return commands.map {
        array[($0[0]-1)...($0[1]-1)].sorted()[($0[2]-1)]
        // ⭐️ array의 인덱스 i부터 j까지의 요소 배열: array[i...j]
    }
}

