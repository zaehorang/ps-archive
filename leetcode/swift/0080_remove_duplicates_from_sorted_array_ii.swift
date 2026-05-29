class Solution {
    func removeDuplicates(_ nums: inout [Int]) -> Int {
        var write = 0
        
        for read in 0..<nums.count {
            if write < 2 || nums[write - 2] != nums[read] {
                nums[write] = nums[read]
                write += 1
            }
        }
        
        return write
    }
}