//
// 3613.swift
// Swift_Algorithm
//
// Created by zaehorang on 2026/2/3.
// https://acmicpc.net/problem/3613
//

import Foundation

func _3613() {
    // Your solution here
    let str = readLine()!
    
    enum Language {
        case java, cpp, error, none
    }
    
    func isChecked(_ str: String) -> Language {
        let strComp =  str.components(separatedBy: "_")
        
        guard str.first! != "_" && str.last! != "_" else { return .error }
        guard Character(String(str.first!)).isLowercase else { return .error }
        guard strComp.allSatisfy({ $0 != "" }) else { return .error }
        
        
        let isCpp = strComp
            .allSatisfy { s in
                if s.allSatisfy({ $0.isLowercase }) { return true }
                return false
            }
        
        let isJava = str.allSatisfy { $0 != "_" }

        if isCpp && isJava {
            return .none
        } else if isCpp {
            return .cpp
        } else if isJava {
            return .java
        }
        
        return .error
    }
    
    let lan = isChecked(str)
    func changeToCpp(_ str: String) -> String {
        var copy = str.map { String($0) }
        for i in 0..<str.count {
            let char = Character(copy[i])
            if char.isUppercase {
                copy[i] = "_" + char.lowercased()
            }
        }
        
        return copy.joined(separator: "")
    }
    
    func changeToJava(_ str: String) -> String {
        var copy = str.map { String($0) }
        
        var indexs: [Int] = []
        
        for i in 0..<copy.count {
            let char = Character(copy[i])
            
            if char == "_" {
                copy[i + 1] = copy[i + 1].uppercased()
            } else {
                indexs.append(i)
            }
        }
        
        var ans = ""
        for i in indexs { ans += copy[i] }
        
        return ans
    }
    
    switch lan {
    case .none:
        print(str)
    case .cpp:
        print(changeToJava(str))
    case .java:
        print(changeToCpp(str))
    case .error:
        print("Error!")
    }
}

// Cleaner implementation (single-pass validation + conversion)
func _3613_2() {
    let input = readLine()!
    let chars = Array(input)

    // Empty input is not expected in the problem, but guard defensively.
    if chars.isEmpty {
        print("Error!")
        return
    }

    var hasUnderscore = false
    var hasUppercase = false

    for c in chars {
        if c == "_" { hasUnderscore = true }
        if c.isUppercase { hasUppercase = true }
    }

    // Mixed styles are invalid.
    if hasUnderscore && hasUppercase {
        print("Error!")
        return
    }

    // --- C++ (snake_case) -> Java (camelCase)
    if hasUnderscore {
        // Validation for snake_case:
        // - must not start/end with '_'
        // - must not contain '__'
        // - must contain only lowercase letters and '_'
        guard chars.first != "_", chars.last != "_" else {
            print("Error!")
            return
        }

        var result = ""
        result.reserveCapacity(chars.count)

        var shouldUppercaseNext = false
        var prevWasUnderscore = false

        for c in chars {
            if c == "_" {
                // no consecutive underscores
                if prevWasUnderscore {
                    print("Error!")
                    return
                }
                prevWasUnderscore = true
                shouldUppercaseNext = true
                continue
            }

            // must be lowercase letter
            if !c.isLowercase {
                print("Error!")
                return
            }

            prevWasUnderscore = false

            if shouldUppercaseNext {
                result.append(contentsOf: String(c).uppercased())
                shouldUppercaseNext = false
            } else {
                result.append(c)
            }
        }

        // If the string ended with '_' this would have been caught by the guard above.
        print(result)
        return
    }

    // --- Java (camelCase) -> C++ (snake_case)
    // Validation for java:
    // - first char must be lowercase
    // - must contain only letters (no underscores)
    guard chars.first!.isLowercase else {
        print("Error!")
        return
    }

    var result = ""
  

    for c in chars {
        // underscores are disallowed in java style (already ensured by hasUnderscore == false)
        if c == "_" {
            print("Error!")
            return
        }

        // must be a letter; (problem constraints are typically letters + '_')
        if !(c.isLowercase || c.isUppercase) {
            print("Error!")
            return
        }

        if c.isUppercase {
            result.append("_")
            result.append(contentsOf: String(c).lowercased())
        } else {
            result.append(c)
        }
    }

    print(result)
}
