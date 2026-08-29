def solution(A,B):
    answer = 0

    # [실행] 버튼을 누르면 출력 값을 볼 수 있습니다.
    a = sorted(A, reverse=True)
    b = sorted(B)
    
    for i in range(len(a)):
        answer += a[i] * b[i]

    return answer