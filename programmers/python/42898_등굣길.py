def solution(m, n, puddles):
    MOD = 1_000_000_007

    # dp[y][x] = (x, y) 위치까지 오는 경로의 수
    dp = [[0] * m for _ in range(n)]

    # 웅덩이 좌표를 빠르게 확인하기 위해 set으로 변환
    puddles = {(x - 1, y - 1) for x, y in puddles}

    # 시작점
    dp[0][0] = 1

    for y in range(n):
        for x in range(m):
            # 웅덩이는 갈 수 없음
            if (x, y) in puddles:
                dp[y][x] = 0
                continue

            # 시작점은 이미 1로 설정
            if x == 0 and y == 0:
                continue

            # 위에서 오는 경우
            if y > 0:
                dp[y][x] += dp[y - 1][x]

            # 왼쪽에서 오는 경우
            if x > 0:
                dp[y][x] += dp[y][x - 1]

            dp[y][x] %= MOD

    return dp[n - 1][m - 1]