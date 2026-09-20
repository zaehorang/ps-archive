def solution(n):
    answer = 0
    
    # 연속된 자연수 구간을 투 포인터로 탐색
    start = 1
    end = 1
    total = 1
    
    while end <= n:
        if total < n:
            # 합이 작으면 오른쪽 범위를 늘림
            end += 1
            total += end
            
        elif total > n:
            # 합이 크면 왼쪽 값을 제거
            total -= start
            start += 1
            
        else:
            # 합이 n이면 경우의 수 추가 후 다음 구간 탐색
            answer += 1
            end += 1
            total += end
    
    return answer