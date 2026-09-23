def solution(n):
    '''
    n의 다음 숫자
    - n보다 큰 자연수
    - 2진수로 변환했을 때 1의 개수가 같다
    - 두 조건을 만족하는 가장 작은 수
    
    2진수 칸 arr 
    - 
    
    '''
    
    
    def get_binary_one_count(n):
        return str(bin(n)).count('1')
    
    one_cnt = get_binary_one_count(n)
    
    answer = n + 1
    while True:
        if get_binary_one_count(answer) == one_cnt:
            return answer
        answer += 1
        