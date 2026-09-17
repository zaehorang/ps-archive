def solution(n):
    answer = 0
    
    while n != 0:
        remainder = n % 10
        n //= 10
        answer += remainder

    return answer