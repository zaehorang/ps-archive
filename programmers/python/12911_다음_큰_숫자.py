def solution(n):
    '''
    n의 다음 큰 숫자
    1. n보다 큰 자연수
    2. 2진수로 변환했을 때 1의 개수가 같음
    3. 위 조건을 만족하는 가장 작은 수

    풀이
    - 가장 작은 수를 찾아야 하므로 n + 1부터 순서대로 확인한다.
    - 각 숫자를 2진수로 변환하고 1의 개수를 비교한다.
    - 처음 조건을 만족하는 숫자가 가장 작은 수이므로 바로 반환한다.

    → 입력 범위가 크지 않고,
      각 숫자의 1 개수를 확인하는 비용도 작기 때문에
      복잡하게 비트를 직접 조작하지 않고 순차 탐색해도 충분하다.
    '''

    def get_binary_one_count(num):
        return bin(num).count('1')

    # n의 2진수에서 1의 개수
    one_cnt = get_binary_one_count(n)

    # n보다 큰 수부터 작은 순서대로 탐색
    answer = n + 1

    while True:
        # 1의 개수가 같다면 가장 먼저 발견한 수가 최소값
        if get_binary_one_count(answer) == one_cnt:
            return answer

        answer += 1