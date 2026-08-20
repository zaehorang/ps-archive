from collections import deque

def solution(bridge_length, weight, truck_weights):
    dq = deque([0] * bridge_length)
    current_weight = 0
    time = 0
    
    def append_truck(weight):
        nonlocal current_weight
        nonlocal dq
        dq.append(weight)
        current_weight += weight
    
    for truck_weight in truck_weights:
        # 트럭 추가 가능하면
        if current_weight + truck_weight <= weight:
            current_weight -= dq.popleft()
            append_truck(truck_weight)
            time += 1
        else: # 트럭 추가 불가능하면
            # 다리 위에 자리 만들기
            while current_weight + truck_weight > weight:
                time += 1
                current_weight -= dq.popleft()
                dq.append(0)
            
            dq.pop()  # 임시 0 제거 후 트럭 진입
            append_truck(truck_weight)

    time += bridge_length
    return time