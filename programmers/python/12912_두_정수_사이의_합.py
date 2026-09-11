def solution(a, b):
    # a가 더 크면 두 값을 교환
    # Python은 오른쪽 값을 먼저 평가한 뒤 각각 대입하므로 swap 가능
    if a > b:
        a, b = b, a
    
    # a부터 b까지의 합
    return sum(range(a, b + 1))