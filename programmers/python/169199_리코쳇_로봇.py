from collections import deque

def solution(board):
    '''
    리코쳇 로봇

    - 상하좌우 중 한 방향으로 이동
    - 한 번 움직이면 장애물(D)이나 벽을 만날 때까지 계속 이동
    - 목표(G)에 도달하기 위한 최소 이동 횟수 반환

    BFS
    - 일반 BFS: 한 칸 이동한 위치가 다음 노드
    - 이 문제: 끝까지 미끄러져 '멈춘 위치'가 다음 노드

    visited[x][y]
    - 해당 위치에 '멈춰서' 방문한 적이 있는지 기록
    - BFS이므로 처음 방문했을 때가 최소 이동 횟수
    '''

    n = len(board)
    m = len(board[0])

    directions = [
        (0, 1),   # 오른쪽
        (1, 0),   # 아래
        (0, -1),  # 왼쪽
        (-1, 0)   # 위
    ]

    # 시작점 찾기
    for x in range(n):
        for y in range(m):
            if board[x][y] == 'R':
                start = (x, y)

    q = deque([start])

    # -1: 아직 해당 위치에 멈춰본 적 없음
    # 0 이상: 시작점에서 해당 위치까지 필요한 이동 횟수
    visited = [[-1] * m for _ in range(n)]
    visited[start[0]][start[1]] = 0

    def slide(x, y, dx, dy):
        '''
        현재 위치에서 한 방향으로 끝까지 이동한다.

        중요한 점:
        - 이동 중간에 visited인 칸이 있어도 그냥 지나간다.
        - visited는 '지나간 칸'이 아니라 '멈춘 위치'를 관리한다.
        '''

        while True:
            nx = x + dx
            ny = y + dy

            # 다음 위치가 게임판 밖이거나 장애물이면
            # 더 갈 수 없으므로 현재 위치에서 멈춘다.
            if (
                not (0 <= nx < n and 0 <= ny < m)
                or board[nx][ny] == 'D'
            ):
                return x, y

            # 이동 가능하면 계속 미끄러진다.
            x = nx
            y = ny

    while q:
        x, y = q.popleft()

        # BFS이므로 G를 처음 만났을 때가 최소 이동 횟수
        if board[x][y] == 'G':
            return visited[x][y]

        for dx, dy in directions:

            # 한 방향으로 끝까지 이동한 뒤의 정지점
            nx, ny = slide(x, y, dx, dy)

            # 이미 방문한 정지점이라면
            # BFS 특성상 더 짧은 경로가 될 수 없으므로 생략
            if visited[nx][ny] != -1:
                continue

            visited[nx][ny] = visited[x][y] + 1
            q.append((nx, ny))

    # 모든 정지점을 탐색해도 G에 도달하지 못함
    return -1