def solution(n, stations, w):
    '''
    [문제]
    1 ~ n번 아파트가 일렬로 존재한다.
    stations에는 이미 설치된 기지국의 위치가 오름차순으로 주어진다.
    기지국은 자신의 위치를 기준으로 양쪽 w만큼 전파를 전달한다.

    [핵심 아이디어]
    모든 아파트를 직접 확인할 필요 없이,
    기존 기지국이 커버하지 못하는 "빈 구간"의 길이만 구한다.

    기지국 1개가 커버할 수 있는 아파트 수:
        w + 1 + w = 2 * w + 1

    따라서 빈 구간의 길이가 gap이라면
    필요한 기지국 수:
        ceil(gap / (2 * w + 1))


    [주의점]
    1. 범위의 양 끝이 포함되는지 확인할 것.
       예) 기지국 위치가 5, w = 1이면
           [4, 5, 6] → 총 3칸 = 2 * w + 1

    2. 기존 기지국 사이의 빈 구간 길이에 주의할 것.
       이전 커버 마지막 위치 = before_r
       현재 커버 시작 위치 = current_l

       빈 구간:
           before_r + 1 ~ current_l - 1

       따라서 빈 구간 길이:
           current_l - before_r - 1

    3. 첫 번째 기지국 앞과 마지막 기지국 뒤의 구간도 고려해야 한다.

    4. 양의 정수의 올림 나눗셈은 다음처럼 계산할 수 있다.
           ceil(a / b)
           = (a + b - 1) // b

       즉,
       "분자에 분모 - 1을 더한 뒤 //로 나눈다."

       예)
           ceil(4 / 3) = 2
           (4 + 3 - 1) // 3
           = 6 // 3
           = 2

       딱 나누어떨어지는 경우도 동일하다.
           ceil(6 / 3) = 2
           (6 + 3 - 1) // 3
           = 8 // 3
           = 2

    시간복잡도: O(len(stations))
    '''

    answer = 0

    # 기지국 하나가 커버할 수 있는 아파트 수
    coverage = 2 * w + 1

    # 지금까지 기존 기지국이 커버한 가장 오른쪽 아파트
    # 처음에는 아무것도 커버하지 않았으므로 0
    before_r = 0

    for station in stations:
        current_l = station - w
        current_r = station + w

        # 이전 커버 범위와 현재 기지국 사이에 빈 구간이 있다면
        if current_l > before_r:
            gap = current_l - before_r - 1

            # ceil(gap / coverage)
            # 양의 정수 올림 나눗셈:
            # (분자 + 분모 - 1) // 분모
            answer += (gap + coverage - 1) // coverage

        # stations가 오름차순이므로
        # 현재 기지국의 오른쪽 끝이 다음 기준점이 된다.
        before_r = current_r

    # 마지막 기존 기지국 이후 ~ n까지 남은 구간
    if before_r < n:
        gap = n - before_r

        # 남은 구간 역시 올림 나눗셈으로 필요한 기지국 수 계산
        answer += (gap + coverage - 1) // coverage

    return answer