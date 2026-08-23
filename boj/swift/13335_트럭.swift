//
//  13335.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 11/7/25.
//


func _13335() {
    let NWL = readLine()!.split(separator: " ").map { Int($0)! }
    let (N, W, L) = (NWL[0], NWL[1], NWL[2])
    
    let trucks = readLine()!.split(separator: " ").map { Int($0)! }
    
    var ans = 0
    
    var bridge: [Int] = .init(repeating: 0, count: W)
    var currentWeight: Int = 0
    
    var waitedTruckIndex = 0
    
    while true {
        if waitedTruckIndex == N {
            var index = 0
            
            for i in bridge {
                if i == 0 { index += 1 } else { break }
            }

            ans += (bridge.count - index)
            break
        }
        
        currentWeight -= bridge.removeLast()
        
        var truck = 0
        
        if currentWeight + trucks[waitedTruckIndex] <= L  {
            truck = trucks[waitedTruckIndex]
            waitedTruckIndex += 1
        }
        
        bridge.insert(truck, at: 0)
        currentWeight += truck
        
        ans += 1
    }
    
    print(ans)
}
