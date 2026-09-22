from collections import deque

def solution(begin, target, words):
    '''
    한 번에 한 개의 알파벳만 바꿀 수 있고,
    words에 있는 단어로만 변환할 수 있다.

    목표:
    begin -> target으로 가는 최소 변환 횟수 구하기

    핵심:
    - 한 번의 변환 비용은 모두 1
    - 최소 이동 횟수를 구하는 문제
    -> BFS가 적합

    BFS에서는 처음 방문한 순간이
    해당 단어까지 가는 최소 거리이므로
    visited를 하나만 사용하면 된다.
    '''

    def can_go(a, b):
        # 두 단어가 정확히 한 글자만 다른지 확인
        cnt = 0

        for i in range(len(a)):
            if a[i] != b[i]:
                cnt += 1

        return cnt == 1

    # -------------------------
    # 기존 DFS 풀이
    # -------------------------

    # answer = float('inf')

    # def dfs(word, visited):
    #     nonlocal answer

    #     if word == target:
    #         answer = min(answer, len(visited))
    #         return

    #     for idx in range(len(words)):
    #         if idx in visited:
    #             continue

    #         if can_go(word, words[idx]):
    #             # DFS는 경로마다 방문 상태가 다르므로
    #             # visited를 복사해서 다음 경로로 넘김
    #             new_visited = visited.copy()
    #             new_visited.append(idx)

    #             dfs(words[idx], new_visited)

    # dfs(begin, [])

    # return 0 if answer == float('inf') else answer


    # -------------------------
    # BFS 풀이
    # -------------------------

    # words의 각 단어를 방문했는지 기록
    # BFS에서는 처음 방문한 경로가 최소 거리이므로
    # visited 하나만 공유해도 된다.
    visited = [False] * len(words)

    # queue에는
    # (현재 단어, 현재까지의 변환 횟수)를 저장
    queue = deque([(begin, 0)])

    while queue:
        # BFS는 먼저 들어온 값부터 꺼낸다.
        # 따라서 변환 횟수가 작은 상태부터 탐색된다.
        word, count = queue.popleft()

        # target을 처음 만난 순간이 최소 변환 횟수
        if word == target:
            return count

        for idx in range(len(words)):
            # 이미 방문한 단어는 다시 볼 필요 없음
            if visited[idx]:
                continue

            # 현재 단어에서 한 글자만 바꿔 갈 수 있다면
            if can_go(word, words[idx]):
                # 큐에 넣는 순간 방문 처리
                # 그래야 다른 경로에서 같은 단어를
                # 중복해서 큐에 넣지 않는다.
                visited[idx] = True

                queue.append(
                    (words[idx], count + 1)
                )

    # 끝까지 target에 도달하지 못한 경우
    return 0