//
//  42583.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 10/22/24.
//

import Foundation

// 트럭이 내리면서 올라타는 경우 고려가 안됨..?
func solution1_42583(_ bridge_length:Int, _ weight:Int, _ truck_weights:[Int]) -> Int {
    var truckIndex = 1
    var timer = 1
    var queue = [truck_weights[0]]
    
    while !queue.isEmpty {
        let total = queue.reduce(0) { $0 + $1 }
        
        if (queue.count + 1) > bridge_length ||
            truckIndex == truck_weights.count ||
            (total + truck_weights[truckIndex]) > weight
        {
            // 조건에 의해 트럭을 더 추가할 수 없다면
            print(queue)
            removeQueue()
            continue
        }
        
        queue.append(truck_weights[truckIndex])
        truckIndex += 1
    }
    
    func removeQueue() {
        if queue.count == 1 {
            timer += bridge_length
            queue = []
            if truckIndex < truck_weights.count {
                queue.append(truck_weights[truckIndex])
                truckIndex += 1
            }
        } else if queue.count > 1 {
            timer += 1
            queue.removeFirst()
        }
    }
    
    return timer
}


func solution_42583(_ bridge_length:Int, _ weight:Int, _ truck_weights:[Int]) -> Int {
    var timer = 0
    var queue = [Int](repeating: 0, count: bridge_length)
    var idx = 0
    
    while !queue.isEmpty  {
        timer += 1
        
        queue.removeFirst()
        
        let total = queue.reduce(0) { $0 + $1 }
        
        if idx < truck_weights.count {
            if (total + truck_weights[idx]) <= weight {
                queue.append(truck_weights[idx])
                idx += 1
            } else {
                queue.append(0)
            }
        }
    }
    return timer
}
