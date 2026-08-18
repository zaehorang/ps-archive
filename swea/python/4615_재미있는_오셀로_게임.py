T = int(input())

for i in range(1, T + 1):
    N, M = map(int, input().split())

    table = [[0] * N for _ in range(N)]

    middle = N // 2

    # 초기 세팅
    table[middle][middle] = 2
    table[middle][middle - 1] = 1
    table[middle - 1][middle - 1] = 2
    table[middle - 1][middle] = 1

    # 8방위 (y, x)
    directions = [
        (1, 0),
        (1, -1),
        (0, -1),
        (-1, -1),
        (-1, 0),
        (-1, 1),
        (0, 1),
        (1, 1)
    ]

    def go_othello(x, y, color, direction):
        nx = x + direction[1]
        ny = y + direction[0]

        if nx < 0 or ny < 0 or nx >= N or ny >= N:
            return False

        if table[ny][nx] == color:
            return True
        elif table[ny][nx] == 0:
            return False
        else:
            if go_othello(nx, ny, color, direction):
                table[ny][nx] = color
                return True

        return False

    for _ in range(M):
        x, y, turn = map(int, input().split())
        x -= 1
        y -= 1
        
        table[y][x] = turn

        for direction in directions:
            go_othello(x, y, turn, direction)

    black = sum(row.count(1) for row in table)
    white = sum(row.count(2) for row in table)

    print(f"#{i} {black} {white}")