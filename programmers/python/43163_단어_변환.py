from collections import deque

def solution(begin, target, words):
    def can_go(a, b):
        cnt = 0

        for i in range(len(a)):
            if a[i] != b[i]:
                cnt += 1

        return cnt == 1

    visited = [False] * len(words)

    # 현재 단어, 지금까지 변환한 횟수
    queue = deque([(begin, 0)])

    while queue:
        word, count = queue.popleft()

        if word == target:
            return count

        for idx in range(len(words)):
            if visited[idx]:
                continue

            if can_go(word, words[idx]):
                visited[idx] = True
                queue.append((words[idx], count + 1))

    return 0