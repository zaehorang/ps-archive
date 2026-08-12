def solution(A, B):
    ''' 
    a, b 팀 사원들 서로 자연수 갖는다.
    b팀은 a팀이 어떤 순서로 어떤 값을 내는지 알고 있음
    
    
    승리 규칙 -> a 팀과 b팀 한 명씩 나와서 서로의 수 비교 후에 이긴팀 1점, 무승무 0점
    b팀이 가장 높은 점수를 받을 때 점수 return
    
    - a와 b를 비교할 때도 차이가 적게 나서 이겨야 다른 상황에서도 이길 확률이 높다.
    - A의 순서가 의미가 있나? 어차피 b의 순서를 바꾸는거니 A도 정렬해서 비교하는게 더 편할 수도..
    
    B의 가장 큰 수
        - A보다 크며
        - A와 차이가 덜 나게
    '''
    
    '''
    <solution>
    1. A 내림차순 정렬
    2. B도 내림차순 정렬
    3. pointer로 B에서 가장 큰 수가 이길 수 있는 수를 A 배열에서 찾고 인덱스 기록
    
    7531
    6666
    '''
    
    A.sort(reverse=True)
    B.sort(reverse=True)
    
    point = 0
    
    for elem_a in A:
        if B[point] > elem_a:
            point += 1
    
    return point