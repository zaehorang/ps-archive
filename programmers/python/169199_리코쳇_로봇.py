from collections import deque

def solution(board):
    '''
    상 하 좌 우
    
    끝까지 미끄러진다.
        장애물, 게임판 가장자리
    
    D: 장애물
    G: 목표지점
    R: 시작점
    
    return
        몇 번 움직이는지
        못가면 -1
        
    Solution
        1. 특정 방향으로 쭉 가는 method
            - 갈 수 있는 방향 모두 가기
            - 멈춘 곳 표시
                - 처음 위치면 다시 1로 출발
                - 이미 온 곳이면 끝
        - BFS 방식으로 위치 잡기
    '''
    # 1. setting
    table = []
    
    x = len(board)
    y = len(board[0])
    
    q = deque()
    visited = [[-1] * y for _ in range(x)]
    
    # make table 
    # find point R
    for i in range(x):
        row = []
        for j in range(y):
            elem = board[i][j]
            row.append(elem)
            
            if elem == 'R':
                q.append((i, j))
                visited[i][j] = 0
        table.append(row)
    
    directions = [(0, 1), (1, 0), (0, -1), (-1, 0)]
    
    
    def slide(direction, point):
        current_x = point[0]
        current_y = point[1]
        
        start_cnt = visited[current_x][current_y]
        
        while True:
            new_x = current_x + direction[0]
            new_y = current_y + direction[1]
            
            # print(f"{new_x}, {new_y}")
            if (
            new_x < 0 or new_y < 0
            or new_x >= x or new_y >= y
            or table[new_x][new_y] == "D"
            ):
                current_cnt = visited[current_x][current_y]
                
                if current_cnt == -1:
                    visited[current_x][current_y] = start_cnt + 1
                    q.append((current_x, current_y))
                    # print(f"{current_x}, {current_y}")
                break 

            current_x = new_x
            current_y = new_y
    
    while q:
        p = q.popleft()
        p_x = p[0]
        p_y = p[1]
        
        if table[p_x][p_y] == "G":
            return visited[p_x][p_y]
        
        for direct in directions:
            slide(direct, p)
        
    return -1