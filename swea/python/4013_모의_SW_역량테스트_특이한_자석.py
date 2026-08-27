T = int(input())

for test_case in range(1, T + 1):
    K = int(input())

    cogwheels = [
        list(map(int, input().split()))
        for _ in range(4)
    ]

    # 각 자석의 현재 12시 방향 index
    start_index = [0, 0, 0, 0]

    def right_idx(n):
        return (start_index[n] + 2) % 8

    def left_idx(n):
        return (start_index[n] + 6) % 8

    for _ in range(K):
        n, direction = map(int, input().split())
        n -= 1

        # 각 자석이 이번 명령에서 회전할 방향
        # 0: 회전 안 함
        # 1: 시계 방향
        # -1: 반시계 방향
        rotate = [0, 0, 0, 0]
        rotate[n] = direction

        # 오른쪽으로 전파
        for i in range(n, 3):
            current_pole = cogwheels[i][right_idx(i)]
            next_pole = cogwheels[i + 1][left_idx(i + 1)]

            # 같은 극이면 회전 전파 종료
            if current_pole == next_pole:
                break

            # 다른 극이면 반대 방향으로 회전
            rotate[i + 1] = -rotate[i]

        # 왼쪽으로 전파
        for i in range(n, 0, -1):
            current_pole = cogwheels[i][left_idx(i)]
            next_pole = cogwheels[i - 1][right_idx(i - 1)]

            if current_pole == next_pole:
                break

            rotate[i - 1] = -rotate[i]

        # 회전 방향을 모두 결정한 후 실제 회전
        for i in range(4):
            start_index[i] = (start_index[i] - rotate[i]) % 8

    answer = 0

    for i in range(4):
        if cogwheels[i][start_index[i]] == 1:
            answer += 2 ** i

    print(f"#{test_case} {answer}")