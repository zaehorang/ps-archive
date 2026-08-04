import heapq


def solution(scoville, K):
    """
    모든 음식의 스코빌 지수를 K 이상으로 만들기 위해
    필요한 최소 혼합 횟수를 반환한다.

    더 이상 음식을 섞을 수 없는데 최솟값이 K보다 작다면 -1을 반환한다.
    """

    # 원본 리스트를 변경하지 않도록 복사
    heap = scoville[:]
    heapq.heapify(heap)

    mix_count = 0

    # heap[0]은 현재 가장 작은 스코빌 지수
    while heap and heap[0] < K:
        # 음식을 섞으려면 최소 두 개가 필요하다.
        if len(heap) < 2:
            return -1

        first = heapq.heappop(heap)
        second = heapq.heappop(heap)

        new_scoville = first + second * 2
        heapq.heappush(heap, new_scoville)

        mix_count += 1

    return mix_count