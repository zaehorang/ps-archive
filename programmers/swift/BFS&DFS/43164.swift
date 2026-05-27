//
//  43164.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 9/28/24.
//


func solution_43164(_ tickets:[[String]]) -> [String] {
    let ticketsCnt = tickets.count
    var isUsed = [Bool](repeating: false, count: ticketsCnt)
    
    var ans = [String](repeating: "", count: ticketsCnt + 1)
    var findAns = false
    
    func findFirstTicketIdx( _ city: String) -> [Int] {
        var ticketToCity: [Int] = []
        
        for i in 0..<ticketsCnt {
            if tickets[i][0] == city { ticketToCity.append(i) }
        }
        
        ticketToCity.sort {
            tickets[$0][1] <= tickets[$1][1]
        }
        return ticketToCity
    }
    
    func recursion(_ n: Int, _ idxArr: [Int]) {
        if n == ticketsCnt {
            print(n)
            findAns = true
            return
        }
        
        for i in idxArr {
            if !isUsed[i] && !findAns {
                isUsed[i] = true
                let destination = tickets[i][1]
                ans[n + 1] = destination
                recursion(n + 1, findFirstTicketIdx(destination))
                isUsed[i] = false
            }
        }
    }
    
    // 인천 티켓 찾기
    recursion(0,findFirstTicketIdx("ICN"))
    ans[0] = "ICN"
    return ans
}
