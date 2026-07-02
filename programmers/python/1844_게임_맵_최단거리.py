from collections import deque

def solution(maps):
    # bfs로 도착지에 먼저 도착하는게 최소 거리
    # 막힌 경우 -1 리턴
    # (0, 0) -> (4, 4)
    
    n = len(maps)
    m = len(maps[0])
    
    directions = [
        (0, 1),
        (1, 0),
        (0, -1),
        (-1, 0)
    ]
    
    queue = deque()
    queue.append((0, 0))
    
    visited = [[False] * m for _ in range(n)]
    visited[0][0] = True
    
    while queue:
        row, col = queue.popleft()
        
        for dr, dc in directions:
            next_row = row + dr
            next_col = col + dc
    
            if next_row < 0 or next_row >= n or next_col < 0 or next_col >= m:
                continue
            if visited[next_row][next_col]: 
                continue
            if maps[next_row][next_col] == 0:
                continue
        
            visited[next_row][next_col] = True
            queue.append((next_row, next_col))

            maps[next_row][next_col] = maps[row][col] + 1

            if next_row == n - 1 and next_col == m - 1:
                return maps[next_row][next_col]
    
    return -1