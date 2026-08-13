import heapq

def solution(n, works):
    '''
    [문제]
    야근 피로도 = 남은 작업량 각각의 제곱의 합
    n시간 동안 1시간에 작업량 1을 처리할 수 있을 때,
    야근 피로도를 최소화한다.

    works 길이 <= 20,000
    n <= 1,000,000


    [접근]

    1. 어떤 작업부터 줄여야 할까?

    작업량이 x일 때 1만큼 줄이면 피로도 감소량은

        x² - (x - 1)²
        = 2x - 1

    따라서 작업량 x가 클수록,
    1만큼 감소시켰을 때 피로도가 더 많이 줄어든다.

    → 매 순간 "현재 작업량이 가장 큰 작업"을 1 감소시키는 것이 최적이다.
    → 그리디


    2. 가장 큰 값을 어떻게 반복해서 찾을까?

    n은 최대 1,000,000이므로
    매번 works를 정렬하거나 max()로 최대값을 찾으면 비효율적이다.

    최대값을 반복해서 꺼내고 다시 넣어야 하므로 Heap을 사용한다.

    Python의 heapq는 Min Heap이므로
    작업량에 음수를 붙여 Max Heap처럼 사용한다.


    [예시]

    works = [4, 3, 3], n = 4

    [4, 3, 3]
     ↓ 가장 큰 4 감소
    [3, 3, 3]
     ↓
    [2, 3, 3]
     ↓
    [2, 2, 3]
     ↓
    [2, 2, 2]

    최대값부터 감소시키면서 결과적으로 작업량이 평탄해진다.


    [시간 복잡도]

    Heap 생성: O(W)
    n번 pop/push: O(n log W)

    → O(n log W)

    W = len(works)
    '''

    # n시간 안에 모든 작업을 처리할 수 있으면
    # 남은 작업량이 없으므로 피로도는 0
    if sum(works) <= n:
        return 0

    # Python heapq는 Min Heap
    # 음수로 저장해서 가장 큰 작업량을 먼저 꺼낼 수 있게 만든다.
    max_heap = [-work for work in works]
    heapq.heapify(max_heap)

    # n시간 동안 매번 가장 큰 작업량을 1씩 감소
    for _ in range(n):
        max_work = -heapq.heappop(max_heap)
        if max_work == 0: break
        
        max_work -= 1

        heapq.heappush(max_heap, -max_work)

    # Heap에는 음수로 저장되어 있지만
    # 제곱하면 동일하므로 그대로 계산할 수 있다.
    return sum(work ** 2 for work in max_heap)