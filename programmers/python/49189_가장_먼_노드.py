from collections import deque

# BFS는 “이동 횟수”가 최단거리일 때 쓰고, 
# Dijkstra는 “이동 비용의 합”이 최단거리일 때 쓰는 알고리즘이야.

def solution(n, edge):
    
    # 1. make graph
    graph = [[] for _ in range(n + 1)]
    for a, b in edge:
        graph[a].append(b)
        graph[b].append(a)
    
    # 2. BFS 알고리즘으로 dist 구하기
    dist = [-1] * (n + 1)
    dist[1] = 0
    
    queue =deque([1])
    
    while queue:
        current_node = queue.popleft()
        
        for next_node in graph[current_node]:
            if dist[next_node] == -1:
                dist[next_node] = dist[current_node] + 1
                queue.append(next_node)
    
    
    max_dist = max(dist)
    return dist.count(max_dist)