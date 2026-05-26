//
//  150370.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 9/9/25.
//  (1) 개인정보 수집 유효기간
//  https://school.programmers.co.kr/learn/courses/30/lessons/150370

import Foundation


func _150370(_ today:String, _ terms:[String], _ privacies:[String]) -> [Int] {
    
    let termsDic = makeTemrsToDic(terms: terms)
    let todayArr = parseDateStringToArr(today)
    
    var n = 1
    
    var ans = [Int]()
    
    for privacy in privacies {
        let privacyArr = privacy.split(separator: " ").map { String($0) }
        let privacyDate = privacyArr[0]
        let privacyType = privacyArr[1]
        
        var parsingPrivacyDate = parseDateStringToArr(privacyDate)
        parsingPrivacyDate = addMonthTo(
            parsingPrivacyDate,
            for: termsDic[privacyType] ?? 0
        )
        
        if isExpired(on: todayArr, expiry: parsingPrivacyDate) {
            ans.append(n)
        }
        
        n += 1
    }
    
    return ans
    
    // MARK: - Helper Methods
    func makeTemrsToDic(terms: [String]) -> [String: Int] {
        var newDict = [String: Int]()
        
        for str in terms {
            let term = str.split(separator: " ")
            newDict[String(term[0])] = Int(term[1])!
        }
        
        return newDict
        
    }

    // return: [year, month, day]
    func parseDateStringToArr(_ date: String) -> [Int] {
        date.split(separator: ".").map { Int($0)! }
    }


    // 주의 테케: addMonthTo([2019, 12, 1], for: 12)
    func addMonthTo(_ date: [Int], for n: Int) -> [Int] {
        var (year, month, day) = (date[0], date[1], date[2])
        
        let (y, m) = (n / 12 , n % 12)
        
        year += y
        month += m
        
        if month > 12 {
            year += (month / 12)
            month = (month % 12)
        }
        
        day -= 1
        if day < 1 {
            day = 28
            month -= 1
            if month < 1 {
                year -= 1
                month = 12
            }
        }
        
        return [year, month, day]
    }

    func isExpired(on today: [Int], expiry: [Int]) -> Bool {
        for i in 0..<3 {
            if today[i] > expiry[i] {
                return true
            } else if today[i] == expiry[i] {
                continue
            } else {
                return false
            }
        }
        return false
    }

}
