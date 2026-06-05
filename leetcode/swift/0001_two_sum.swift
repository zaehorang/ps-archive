class Solution {
    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        var dict: [Int: Int] = [:]

        for i in 0..<nums.count {
            var diff = target - nums[i]

            if let index = dict[diff] {
                return [index, i]
            } else {
                dict[nums[i], default: i] = i
            }
        }
        return []
    }
}