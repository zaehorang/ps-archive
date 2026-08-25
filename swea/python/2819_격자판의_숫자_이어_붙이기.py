T = int(input())

direction = [(1, 0), (0, -1), (-1, 0), (0, 1)]

for t in range(1, T + 1):
    table = [list(map(int, input().split())) for _ in range(4)]
    s = set()
    
    def dfs(sx, sy, num, turn):
        if turn == 7:
            s.add(num)
            return
        
        for (x, y) in direction:
            nx = x + sx
            ny = y + sy
            
            if nx >= 4 or ny >= 4 or nx < 0 or ny < 0: 
                continue
            
            dfs(nx, ny, num * 10 + table[nx][ny], turn + 1)
	
    for i in range(4):
        for j in range(4):
            dfs(i, j, table[i][j], 1)
            
    print(f"#{t} {len(s)}")
