def solution(n, times):
    '''
    한 심사대에 한 명
    
    모든 사람 검사 최소 시간
    
    0 < n <= 10^9
    0 < time <= 10^9 
    
    입장 시간 말고 끝나는게 빨라야 한다.
    '''
    
    min_time = 1
    max_time = max(times) * n
    
    
    def cal_total_n(t):
        cnt = 0
        for time in times:
            cnt += t // time
    
        return cnt
    
    while min_time < max_time:
        base_time = (max_time + min_time) // 2
        base = cal_total_n(base_time)
        
        if base < n:
            min_time = base_time + 1
        else:
            max_time = base_time
        
    return min_time