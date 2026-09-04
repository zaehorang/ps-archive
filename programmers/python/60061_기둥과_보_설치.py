def solution(n, build_frame):
    '''
    [x, y, a, b]
    
    a
    - 0: 기둥
    - 1: 보
    
    b
    - 0: 삭제
    - 1: 설치
    
    coords[x][y]
    - [0]&#58; 기둥 존재 여부
    - [1]&#58; 보 존재 여부
    '''

    # 좌표는 0 ~ n까지 존재
    # coords[x][y] = [기둥, 보]
    coords = [
        [[False, False] for _ in range(n + 1)]
        for _ in range(n + 1)
    ]

    # -----------------------------
    # 기둥 설치 가능 여부
    # -----------------------------
    def can_build_col(x, y):

        # 기둥이 범위를 벗어나는 경우
        # 기둥은 (x, y) ~ (x, y+1)이므로 y == n에는 설치 불가능
        if x < 0 or x > n or y < 0 or y >= n:
            return False

        # 1. 바닥 위
        if y == 0:
            return True

        # 2. 보의 오른쪽 끝 위
        if x > 0 and coords[x - 1][y][1]:
            return True

        # 3. 보의 왼쪽 끝 위
        if coords[x][y][1]:
            return True

        # 4. 다른 기둥 위
        if coords[x][y - 1][0]:
            return True

        return False

    # -----------------------------
    # 보 설치 가능 여부
    # -----------------------------
    def can_build_beam(x, y):

        # 보는 (x, y) ~ (x+1, y)
        # 따라서 x == n에는 설치 불가능
        # 바닥(y == 0)에도 보 설치 불가능
        if x < 0 or x >= n or y <= 0 or y > n:
            return False

        # 1. 왼쪽 끝 아래에 기둥
        if coords[x][y - 1][0]:
            return True

        # 2. 오른쪽 끝 아래에 기둥
        if coords[x + 1][y - 1][0]:
            return True

        # 3. 양쪽에 보가 연결되어 있음
        if (
            x > 0
            and x + 1 <= n
            and coords[x - 1][y][1]
            and coords[x + 1][y][1]
        ):
            return True

        return False

    # -----------------------------
    # 현재 전체 구조가 정상인지 확인
    # -----------------------------
    def is_valid():

        for x in range(n + 1):
            for y in range(n + 1):

                # 기둥이 존재한다면
                # 현재 위치에서 설치 가능한 상태여야 함
                if coords[x][y][0]:
                    if not can_build_col(x, y):
                        return False

                # 보가 존재한다면
                # 현재 위치에서 설치 가능한 상태여야 함
                if coords[x][y][1]:
                    if not can_build_beam(x, y):
                        return False

        return True

    # -----------------------------
    # 명령 실행
    # -----------------------------
    for x, y, structure, command in build_frame:

        # =========================
        # 설치
        # =========================
        if command == 1:

            # 기둥
            if structure == 0:
                if can_build_col(x, y):
                    coords[x][y][0] = True

            # 보
            else:
                if can_build_beam(x, y):
                    coords[x][y][1] = True

        # =========================
        # 삭제
        # =========================
        else:

            # 기둥 삭제
            if structure == 0:

                # 일단 삭제
                coords[x][y][0] = False

                # 삭제 후 전체 구조가 불가능하면 복구
                if not is_valid():
                    coords[x][y][0] = True

            # 보 삭제
            else:

                # 일단 삭제
                coords[x][y][1] = False

                # 삭제 후 전체 구조가 불가능하면 복구
                if not is_valid():
                    coords[x][y][1] = True

    # -----------------------------
    # 결과 생성
    # x -> y -> 기둥(0), 보(1) 순서
    # -----------------------------
    answer = []

    for x in range(n + 1):
        for y in range(n + 1):

            if coords[x][y][0]:
                answer.append([x, y, 0])

            if coords[x][y][1]:
                answer.append([x, y, 1])

    return answer