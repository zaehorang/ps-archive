class Solution {
    func majorityElement(_ nums: [Int]) -> Int {
        var dict: [Int: Int] = [:]
        nums.forEach { dict[$0, default: 0] += 1 }

        var ans = 0
        var count = 0

        for (key, value) in dict {
            if count < value { 
                ans = key
                count = value
            }
        }
        return ans
    }
}