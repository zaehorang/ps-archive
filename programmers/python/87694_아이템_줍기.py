from collections import deque


def solution(rectangle, characterX, characterY, itemX, itemY):
    # 좌표를 2배로 확대한다.
    #
    # 원래 좌표 사이에 중간 좌표를 만들어서
    # 복잡한 모서리 부분에서 서로 다른 테두리가
    # 하나의 길처럼 인식되는 문제를 방지한다.
    rectangles = [
        [x1 * 2, y1 * 2, x2 * 2, y2 * 2]
        for x1, y1, x2, y2 in rectangle
    ]

    # 문제에서 원래 좌표 최대값이 50
    # 2배 확대하면 최대 100까지 필요
    board = [[0] * 102 for _ in range(102)]

    # ------------------------------------------------
    # 1. 모든 직사각형 영역을 일단 채운다.
    #
    # 0 : 아무것도 없음
    # 1 : 직사각형 영역
    # ------------------------------------------------
    for x1, y1, x2, y2 in rectangles:
        for x in range(x1, x2 + 1):
            for y in range(y1, y2 + 1):
                board[y][x] = 1

    # ------------------------------------------------
    # 2. 직사각형의 "내부"를 제거한다.
    #
    # 테두리는 남겨야 하므로
    # x1 + 1 ~ x2 - 1
    # y1 + 1 ~ y2 - 1
    # 만 0으로 만든다.
    #
    # 결과적으로 board에서 1인 곳은
    # 우리가 이동할 수 있는 외곽선만 남는다.
    # ------------------------------------------------
    for x1, y1, x2, y2 in rectangles:
        for x in range(x1 + 1, x2):
            for y in range(y1 + 1, y2):
                board[y][x] = 0

    # 시작점과 도착점도 2배
    start_x = characterX * 2
    start_y = characterY * 2

    target_x = itemX * 2
    target_y = itemY * 2

    # ------------------------------------------------
    # 3. 테두리 위에서 BFS
    # ------------------------------------------------
    queue = deque()

    # (x, y, 현재까지 이동 거리)
    queue.append((start_x, start_y, 0))

    visited = [[False] * 102 for _ in range(102)]
    visited[start_y][start_x] = True

    # 상하좌우만 이동
    directions = [
        (1, 0),
        (-1, 0),
        (0, 1),
        (0, -1)
    ]

    while queue:
        x, y, distance = queue.popleft()

        # 아이템에 도착
        if x == target_x and y == target_y:
            # 좌표를 2배 확대했기 때문에
            # 이동 거리 역시 정확히 2배가 되어 있다.
            #
            # 따라서 원래 거리로 복원하기 위해 / 2
            return distance // 2

        for dx, dy in directions:
            nx = x + dx
            ny = y + dy

            # board[y][x] == 1
            # → 테두리이므로 이동 가능
            if board[ny][nx] == 1 and not visited[ny][nx]:
                visited[ny][nx] = True
                queue.append((nx, ny, distance + 1))