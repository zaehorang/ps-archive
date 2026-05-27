class Solution {
    func removeElement(_ nums: inout [Int], _ val: Int) -> Int {
        var newArr = [Int]()
        var count = 0
        nums.forEach {
            if $0 != val { newArr.append($0) }
         }   

        nums = newArr.sorted()
        return newArr.count
    }
}