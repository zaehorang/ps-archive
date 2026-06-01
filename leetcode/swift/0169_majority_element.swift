class Solution {
    func majorityElement(_ nums: [Int]) -> Int {
        // MARK: - 1. HashMap 풀이
        // 각 숫자의 등장 횟수를 저장해서 n / 2보다 많이 나온 값을 찾는 방법
        // 시간복잡도: O(n), 공간복잡도: O(n)
        /*
        var countMap: [Int: Int] = [:]

        for num in nums {
            countMap[num, default: 0] += 1

            if countMap[num]! > nums.count / 2 {
                return num
            }
        }

        return nums[0]
        */

        // MARK: - 2. 정렬 풀이
        // majority element는 절반보다 많이 등장하므로,
        // 정렬하면 반드시 가운데 인덱스에 위치한다.
        // 시간복잡도: O(n log n), 공간복잡도: O(n)
        /*
        let sortedNums = nums.sorted()
        return sortedNums[nums.count / 2]
        */

        // MARK: - 3. Boyer-Moore Voting Algorithm
        // 서로 다른 숫자를 하나씩 상쇄해도,
        // 과반수로 등장하는 숫자는 끝까지 남는다.
        // 시간복잡도: O(n), 공간복잡도: O(1)

        var candidate = 0
        var count = 0

        for num in nums {
            if count == 0 {
                candidate = num
            }

            if num == candidate {
                count += 1
            } else {
                count -= 1
            }
        }

        return candidate
    }
}