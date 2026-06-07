import Foundation

class Solution {
    func isPalindrome(_ s: String) -> Bool {
        let new = s.map { 
            let l = $0.asciiValue!

            if (l >= Character("a").asciiValue! && l <= Character("z").asciiValue!) || 
            (l >= Character("A").asciiValue! && l <= Character("Z").asciiValue!) ||
            (l >= Character("0").asciiValue! && l <= Character("9").asciiValue!)
             {
                return $0.lowercased()
            }  
            return ""
        }.joined(separator: "")

        return new == String(new.reversed())
    }
}