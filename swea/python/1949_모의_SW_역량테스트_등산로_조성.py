directions = [
    (0, 1),
    (1, 0),
    (0, -1),
    (-1, 0)
]


def find_max_positions(table):
    max_height = max(map(max, table))
    positions = []

    for r, row in enumerate(table):
        for c, height in enumerate(row):
            if height == max_height:
                positions.append((r, c))

    return positions


def solution(N, K, table):
    starts = find_max_positions(table)

    max_length = 0
    visited = [[False] * N for _ in range(N)]

    def dfs(y, x, length, used_cut):
        nonlocal max_length

        # 현재까지 만들어진 등산로 길이 갱신
        max_length = max(max_length, length)

        for dy, dx in directions:
            ny = y + dy
            nx = x + dx

            # 범위를 벗어나는 경우
            if ny < 0 or nx < 0 or ny >= N or nx >= N:
                continue

            # 이미 방문한 위치
            if visited[ny][nx]:
                continue

            current_height = table[y][x]
            next_height = table[ny][nx]

            # 1. 다음 칸이 더 낮으면 그냥 이동
            if next_height < current_height:
                visited[ny][nx] = True

                dfs(ny, nx, length + 1, used_cut)

                # 백트래킹
                visited[ny][nx] = False

            # 2. 현재 상태로는 갈 수 없지만,
            #    아직 공사를 사용하지 않았다면 깎아본다.
            elif not used_cut:

                # K만큼까지 깎았을 때 현재 높이보다 낮아질 수 있는가?
                if next_height - K < current_height:

                    original_height = table[ny][nx]

                    # 필요한 만큼만 깎는다.
                    # 현재 높이보다 1만 낮으면 이동 가능하기 때문에
                    # 그 이상 깎을 필요가 없다.
                    table[ny][nx] = current_height - 1

                    visited[ny][nx] = True

                    dfs(ny, nx, length + 1, True)

                    # 백트래킹
                    visited[ny][nx] = False
                    table[ny][nx] = original_height

    # 모든 최고 봉우리에서 DFS 시작
    for y, x in starts:
        visited[y][x] = True

        dfs(y, x, 1, False)

        visited[y][x] = False

    return max_length


# Input
T = int(input())

for tc in range(1, T + 1):
    N, K = map(int, input().split())

    table = [
        list(map(int, input().split()))
        for _ in range(N)
    ]

    answer = solution(N, K, table)

    print(f"#{tc} {answer}")