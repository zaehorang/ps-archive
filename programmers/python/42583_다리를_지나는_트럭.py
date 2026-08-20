from collections import deque

def solution(bridge_length, weight, truck_weights):
    '''
    10kg 견딘다.
    트럭은 순차 진행
    
    bridge_length: queue length (weight sum limit)
    bridge -> queue
    
    무게 제한을 충족했을 때는 남은 거리를 더해서 빼는게 처리가 빠르긴 할 듯
    
    '''
    dq = deque([0] * bridge_length)
    current_weight = 0
    time = 0
    
    def append_truck(weight):
        nonlocal current_weight
        nonlocal dq
        dq.append(weight)
        current_weight += weight
    
    truck_idx = 0
    
    while truck_idx < len(truck_weights):
        truck_weight = truck_weights[truck_idx]
        
        # 트럭 추가 가능하면
        if current_weight + truck_weight <= weight:
            current_weight -= dq.popleft()
        
            append_truck(truck_weight)
            time += 1
        else:
             # 다리 위에 자리 만들기
            while current_weight + truck_weight > weight:
                time += 1
                current_weight -= dq.popleft()
                dq.append(0)
            dq.pop()
            append_truck(truck_weight)
            
        truck_idx += 1
        
    # 마지막 트럭 올라가면 위에 반복문 끝
    time += bridge_length
    return time