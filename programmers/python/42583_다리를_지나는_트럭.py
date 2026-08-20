from collections import deque

def solution(bridge_length, weight, truck_weights):
    current_time = 0
    current_weight = 0
    bridge = deque()  # (트럭 무게, 다리를 빠져나가는 시점)
    
    for truck in truck_weights:
        current_time += 1
        
        # 1. 현재 시간에 이미 다리를 다 건넌 트럭들 제거
        while bridge and bridge[0][1] <= current_time:
            w, _ = bridge.popleft()
            current_weight -= w
            
        # 2. 무게 초과로 다음 트럭이 못 올라오면, 앞 트럭이 나갈 때까지 시간 점프
        while current_weight + truck > weight:
            w, exit_time = bridge.popleft()
            current_weight -= w
            current_time = exit_time  # 앞 트럭이 완전히 빠져나간 시간으로 이동
            
        # 3. 새 트럭 진입 (탈출 예정 시간 = 현재 시간 + 다리 길이)
        bridge.append((truck, current_time + bridge_length))
        current_weight += truck
        
    # 마지막 트럭이 다리를 완전히 빠져나가는 시간이 정답
    return bridge[-1][1]