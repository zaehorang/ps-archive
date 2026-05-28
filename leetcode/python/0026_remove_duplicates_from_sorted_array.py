class Solution:
    def removeDuplicates(self, nums: List[int]) -> int:
        index = 0
        current = -101

        for elem in nums:
            if current < elem:
                nums[index] = elem
                current = elem
                index += 1

        return index