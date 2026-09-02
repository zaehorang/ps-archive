from collections import deque

def solution(progresses, speeds):
    arr = []

    # 각 기능이 완료되는 데 필요한 날짜
    for i in range(len(progresses)):
        day = (100 - progresses[i] + speeds[i] - 1) // speeds[i]
        arr.append(day)

    ans = []
    q = deque(arr)

    while q:
        # 가장 앞 기능의 완료 날짜
        first = q.popleft()
        cnt = 1

        # 앞 기능보다 먼저 또는 동시에 끝나는 기능만 같이 배포
        while q and q[0] <= first:
            q.popleft()
            cnt += 1

        ans.append(cnt)

    return ans