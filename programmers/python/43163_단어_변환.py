def solution(begin, target, words):
    def can_go(a, b):
        cnt = 0

        for i in range(len(a)):
            if a[i] != b[i]:
                cnt += 1

        return cnt == 1

    def find_idx_candidates(word):
        idx_arr = []

        for idx in range(len(words)):
            if can_go(word, words[idx]):
                idx_arr.append(idx)

        return idx_arr

    answer = float('inf')

    def dfs(word, visited):
        nonlocal answer

        if word == target:
            answer = min(answer, len(visited))
            return

        for idx in find_idx_candidates(word):
            if idx in visited:
                continue

            new_visited = visited.copy()
            new_visited.append(idx)

            dfs(words[idx], new_visited)

    dfs(begin, [])

    return 0 if answer == float('inf') else answer