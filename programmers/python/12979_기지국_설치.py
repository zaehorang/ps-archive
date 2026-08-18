import math

def solution(n, stations, w):
    
    '''
    1~n개 아파트 
    stations: 설치된 기지국 위치(아파트 번호)
    
    5g -> 도달 거리 w (양방향)
    
    n = 6
stations = [5]
w = 1
    '''
    
    answer = 0
    
    before_r = 0
    
    for station in stations:
        new_r = station + w
        new_l = station - w
        
        if new_r > n: 
            new_r = n
        
        if new_l <= before_r:
            before_r = new_r
            continue
    
        
        answer += math.ceil((new_l - before_r - 1) / (2 * w + 1))
        
        before_r = new_r

    if before_r < n:
        answer += math.ceil((n - before_r) / (2 * w + 1))
        print('d')
        print(answer)
    return answer