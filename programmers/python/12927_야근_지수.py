def solution(n, works):
    
    '''
    피로도: 야근을 시작한 시점에서 남은 일의 작업량 제곱
    1시간에 1처리
    
    N시간 동안 야근 피로도 최소화
    
    
    works 배열에서 각 elem에 n만큼 차감 가능 -> (elem) ** 2 수열의 최소값 구하기
    
    work <= 5*10^4
    n <= 10^6
    
    0을 만드는게 좋은가?
    골고루 작게 만드는게 좋을가?
    
    그리디..?
    
    
    정렬
    첫 번째 큰 수들 두 번째 큰 수로 만들기.
    ...
    
    -> 모든 경우의 수..? --> 
    
    '''
    
    # 정렬된 배열에서 첫 값과 달라지는 인덱스를 리턴
    # 다 같으면 end_index return
    def find_diff_index(arr):
        count = len(arr)
        if count == 1: return count
        
        value = arr[0]
        
        for i in range(count):
            if value != arr[i]:
                return i
        
        return count
    
    def calculate_index_arr(arr):
        return sum(map(lambda x: x ** 2, arr))
    
    # Solution
    
    works.sort(reverse=True)
    
    count = 0
    
    while n > 0:
        if works[0] == 0: break
        idx = find_diff_index(works)
        
        end_idx = idx
        
        if idx == len(works):
            end_idx = len(works)
        
        # end_idx > n인 경우
        
        for i in range(end_idx):
            works[i] -= 1
            n -= 1
            
            if n == 0: break
        
    return calculate_index_arr(works)
    
    
    
    
        
        