//
//  1076.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 12/16/25.
//  https://www.acmicpc.net/problem/1076

import Foundation

/*
 문제 설명이 좀 부족한 거 같음
 예제를 보고 이해해야 함
 
 처음 색 2개 저항값은 순차적으로 붙는 값
 ex) 4와 2가 나오면 저항값은 42
     그리고 곱해지는 값을 42에 곱하면 된다.
 */

func _1076() {
    enum OhmColor: String {
        case black, brown, red,
             orange, yellow, green,
             blue, violet, grey, white

        /*
         만약 CaseIterable을 붙이면 아래도 가능
         ar value: Int { Self.allCases.firstIndex(of: self)! }
        }
         */
        
        var value: Int {
            switch self {
            case .black: return 0
            case .brown: return 1
            case .red: return 2
            case .orange: return 3
            case .yellow: return 4
            case .green: return 5
            case .blue: return 6
            case .violet: return 7
            case .grey: return 8
            case .white: return 9
            }
        }

        var multiplier: Int {
            Int(pow(10.0, Double(value)))
        }
    }
    
    let a: OhmColor = .init(rawValue: readLine()!)!
    let b: OhmColor = .init(rawValue: readLine()!)!
    let c: OhmColor = .init(rawValue: readLine()!)!
    
    print((a.value * 10 + b.value) * c.multiplier)
}
