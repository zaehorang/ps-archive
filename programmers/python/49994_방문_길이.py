def solution(dirs):
    # 방향별 이동량
    move = {
        "U": (0, 1),
        "D": (0, -1),
        "R": (1, 0),
        "L": (-1, 0)
    }

    x, y = 0, 0

    # 방문한 경로(간선)를 저장
    visited = set()

    for command in dirs:
        dx, dy = move[command]

        nx = x + dx
        ny = y + dy

        # 좌표 범위를 벗어나면 이동 자체를 무시
        if not (-5 <= nx <= 5 and -5 <= ny <= 5):
            continue

        # 같은 길을 반대 방향으로 지나가는 것도 같은 길이므로
        # 양방향을 모두 저장
        visited.add(((x, y), (nx, ny)))
        visited.add(((nx, ny), (x, y)))

        x, y = nx, ny

    # 하나의 길을 양방향으로 2번 저장했으므로 2로 나눔
    return len(visited) // 2