import heapq

def make_new_Scovile(min1, min2):
    return min1 + (min2 * 2)

def solution(scoville, K):
    '''
        n: 2 ~ 1.000.000
        k: 0이상 --> 새롭운 값 계산이 최대를 넘을 일 x
    
        1. 매번 min1, min2를 갖고 스코빌 지수 계산
            - min1이 k 이상이 되면 끝.
            --> 반복되는 min calculate --> min Heap structure
        2. 추가
        3. 반복
        
        모두 K 이상으로 만들 수 없는 경우: -1
            - 다 섞어서 못섞음.
            - 처음부터 못섞기? 없음 len >= 2
    
    '''
    heap = scoville
    heapq.heapify(heap)
    
    answer = 0
    
    while True:
        min1 = heapq.heappop(heap)
        if min1 >= K: break
        if not heap:
            return -1
        min2 = heapq.heappop(heap)

        heapq.heappush(heap, make_new_Scovile(min1, min2))
        
        answer += 1
    
    return answer