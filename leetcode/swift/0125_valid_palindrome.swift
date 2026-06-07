import Foundation

class Solution {
    func isPalindrome(_ s: String) -> Bool {
        let new = s.lowercased().filter { $0.isLetter || $0.isNumber }
        return new == String(new.reversed())
    }
}