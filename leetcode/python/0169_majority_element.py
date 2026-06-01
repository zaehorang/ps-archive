class Solution:
    def majorityElement(self, nums: List[int]) -> int:
        # majority: 절반 이상 카운트
        # 결국 제일 많이 카운트 된다
        candidate = 0
        votes = 0

        for n in nums:
            if votes == 0: candidate = n
            if candidate == n:
                votes += 1
            else:
                votes -= 1
        
        return candidate