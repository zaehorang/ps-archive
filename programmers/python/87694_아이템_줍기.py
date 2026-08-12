from collections import deque

def solution(rectangle, characterX, characterY, itemX, itemY):
    rectangles = [
        [x1 * 2, y1 * 2, x2 * 2, y2 * 2]
        for x1, y1, x2, y2 in rectangle
    ]
    
    board = [[0] * 102 for _ in range(102)]
    
    for x1, y1, x2, y2 in rectangles:
        for x in range(x1, x2 + 1):
            for y in range(y1, y2 + 1):
                board[y][x] = 1
    
    
    for x1, y1, x2, y2 in rectangles:
        for x in range(x1 + 1, x2):
            for y in range(y1 + 1, y2):
                board[y][x] = 0
                
    start_x = characterX * 2
    start_y = characterY * 2
    
    target_x = itemX * 2
    target_y = itemY * 2
    
    queue = deque()
    
    queue.append((start_x, start_y, 0))
    
    visited = [[False] * 102 for _ in range(102)]
    visited[start_y][start_x] = True
    
    directions = [
        (1, 0),
        (-1, 0),
        (0, 1),
        (0, -1)
    ]
    
    while queue:
        x, y, distance = queue.popleft()
        
        if x == target_x and y == target_y:
            return distance // 2
    
        for dx, dy in directions:
            nx = x + dx
            ny = y + dy
            
            if board[ny][nx] == 1 and not visited[ny][nx]:
                visited[ny][nx] = True
                queue.append((nx, ny, distance + 1))