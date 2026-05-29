class Solution:
    def removeDuplicates(self, nums: List[int]) -> int:
        left = 0  # 정답 배열에 다음 값을 넣을 위치

        for right in range(len(nums)):
            # left 앞쪽은 이미 정리된 정답 구간
            # 정답 구간에서 2칸 앞 값과 현재 값이 다르면,
            # 현재 값은 아직 2번 초과로 들어간 것이 아니므로 넣는다
            if left < 2 or nums[left - 2] != nums[right]:
                nums[left] = nums[right]
                left += 1

        return left