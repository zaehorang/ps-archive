""" 시간 초과 - recursive
def solution(triangle):
    answer = 0
    
    height = len(triangle)
    
    def recursive(floor, current, value):
        nonlocal answer
        
        if floor >= (height - 1): 
            if answer <= value:
                answer = value
            return
        
        # 왼쪽
        recursive(floor + 1, current, value + triangle[floor + 1][current])
        # 오른쪽
        recursive(floor + 1, current + 1, value + triangle[floor + 1][current + 1])
    
    
    recursive(0, 0, triangle[0][0])
    
    
    return answer
"""

def solution(triangle):
    dp = [row[:] for row in triangle]

    for floor in range(1, len(dp)):
        for current in range(len(dp[floor])):
            if current == 0:
                # 가장 왼쪽은 바로 위에서만 내려올 수 있음
                dp[floor][current] += dp[floor - 1][current]

            elif current == floor:
                # 가장 오른쪽은 왼쪽 위에서만 내려올 수 있음
                dp[floor][current] += dp[floor - 1][current - 1]

            else:
                # 가운데는 왼쪽 위와 오른쪽 위 중 큰 값을 선택
                dp[floor][current] += max(
                    dp[floor - 1][current - 1],
                    dp[floor - 1][current]
                )

    return max(dp[-1])