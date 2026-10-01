def solution(places):
    '''
    P: 응시자
    O: 빈 테이블
    X: 파티션
    
    잘 지키면 1
    안 지키면 0
    
    조건
        1. 맨해튼 거리 2이하로 앉지 않기
            -> 상하좌우 움직임으로 2 안으로 접근 불가
        2. 파티션 있으면 가능
    
    5 X 5
    
    Solution
    
    1. 사람 위치 찾기
    2. 사람 위치 기준으로 2칸 가능 dfs
        - 테이블이면 갈 수 있음
        언제까지?
            - 3칸 가면 패스
            - 2칸 이내
                사람 있으면 문제
                - 파티션 있으면 패스
    '''
    directions = [(0, 1), (1, 0), (-1, 0), (0, -1)]
    
    visited = [[False] * 5 for _ in range(5)]
    
    answer = [1] * 5
    
    def go(point, cnt, p_idx):
        x, y = point
        place = places[p_idx]
        
        if cnt == 2 or answer[p_idx] == 0:
            return
        
        for (dx, dy) in directions:
            nx, ny = x + dx, y + dy
            
            if not (0 <= nx < 5 and 0 <= ny < 5):
                continue
            
            if visited[nx][ny]:
                continue
            
            if place[nx][ny] == 'P':
                answer[p_idx] = 0
                return 
            
            if place[nx][ny] == 'X':
                continue
            
            visited[nx][ny] = True
            go((nx, ny), cnt + 1, p_idx)
            visited[nx][ny] = False
    
    
    for p_idx in range(5):
        place = places[p_idx]
        
        p_arr = []
        for i in range(5):
            for j in range(5):
                if place[i][j] == "P":
                    p_arr.append((i, j))
        
        for x, y in p_arr:
            if answer[p_idx] == 0:
                break
            visited[x][y] = True
            go((x, y), 0, p_idx)
            visited[x][y] = False
    
    return answer