def solution(dirs):
    '''
    움직인 길 -> 좌표로 판단할 수 있는지? visited point array
    - 해당 좌표를 갔는지 판단보다 이전 점에서 해당 좌표로 간 이력이 있는지 판단해야 할 듯
    
    같은 시작점, 도착점을 판단 -> 순서가 바껴도 가능
    
    - 경계 처리도 해야 함.
    - 명령어 n <= 500
    
    1. 각 좌표를 키로 갖는 dict를 만든다
    2. 각 좌표로 이동할 때, 시작점, 도착점을 dic에 추가
        - 양방향으로 표시
    2-1 이동하면서 해당 좌표 정보가 없으면 경로 + 1, 없으면 0
    '''
    
    visited = {}
    current = (0, 0)
    
    for i in range(-5, 6):
        for j in range(-5, 6):
            visited[(i, j)] = set()
    
    def move(key):
        nonlocal current
        
        if key == "U":
            nx = current[0]
            ny = current[1] + 1 
            if ny > 5:
                return
                
        elif key == "R":
            nx = current[0] + 1
            ny = current[1] 
            if nx > 5:
                return
        elif key == "L":
            nx = current[0] - 1
            ny = current[1]
            if nx < -5:
                return
        elif key == "D":
            nx = current[0]
            ny = current[1] - 1 
            if ny < -5:
                return
        
        visited[(current)].add((nx, ny))
        visited[(nx, ny)].add((current))
                
        current = (nx, ny)
    
    for direct in dirs:
        move(direct)
    
    answer = 0
    for s in visited.values():
        answer += len(s)
    print(visited)
    return answer // 2