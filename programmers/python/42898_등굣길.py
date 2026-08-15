def solution(m, n, puddles):
    '''
    오른쪽, 아래으로만 움직여서 학교가기
    최단 경로 개수 나누기
    
    1 <= m,n <= 100
    
    물에 잠긴 지역 0~10개
    
    근데 오른쪽, 왼쪽으로 갈 수만 있으면 무조건 최소 아닌가..? 모든 경우의 수..?
    
    반대로 무조건 물에 잠긴 경우를 제외..?
    
    
    dp...
    dp[x, y] = dp[x-1, y] + dp[x, y-1]
    
    '''
    
    dp = [[1] * m for _ in range(n)]
    
    # 웅덩이
    for x, y in puddles:
        dp[y-1][x-1] = 0
    
    for y in range(n):
        for x in range(m):
            if y == 0 and x == 0: continue
            if dp[y][x] == 0: continue
            
            if y == 0:
                dp[y][x] = dp[y][x-1]
                continue
            
            if x == 0:
                dp[y][x] = dp[y-1][x]
                continue
            
            dp[y][x] = dp[y-1][x] + dp[y][x-1]
            
    # print(dp)
    return dp[n-1][m-1] % 1000000007