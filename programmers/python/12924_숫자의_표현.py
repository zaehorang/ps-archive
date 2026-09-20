def solution(n):
    '''
    자연수의 합으로 n을 표현할 수 있는 방법의 수
        - 같은 숫자 사용 못한다.
        - 연속된!!!!!!
        
    n <= 10^4
    -> 모든 경우를 재귀로 다 보면
        - 사용한다
        - 안한다
        - 재귀 종료 조건:
            1. 다음 숫자가 남은 숫자보다 큰 경우
            2. 목표 숫자보다 커진 경우
    
    -> 누적합..?
        1. arr[n]: n까지 더할 때 합
        2. two-pointer로 window 크기 정해서
            arr[end] - arr[start]: start~end까지 합
                -> n이 되는 경우 찾기
        => 효율성에서 문제 !!!
        j에서 범위를 줄이는 그리디 풀이가 있나..?
    '''
    answer = 0
    
    # prefix sum
    # cum_arr = [0] * (n+1)
    # for i in range(1, n+1):
    #     cum_arr[i] = cum_arr[i-1] + i
    
    # find
    # for i in range(1, n+1):
    #     for j in range(i):
    #         if cum_arr[i] - cum_arr[j] == n:
    #             answer += 1
    #             break
    
    
    start = 1
    end = 1
    total = 1
    
    while True:
        if start > end:
            break
            
        if total < n:
            end += 1
            total += end
        elif total > n:
            total -= start
            start += 1
        else:
            answer += 1
            end += 1
            total += end
            
    return answer