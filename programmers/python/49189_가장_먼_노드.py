import heapq

# 2. 다익스트라 알고리즘으로 1번을 시작점으로 한 dist 배열 구하기
def dijkstra(graph, n):
    INF = float('inf')
    
    dist = [INF for _ in range(n + 1)]
    dist[1] = 0
    
    # (cost, node)
    heap = [(0, 1)]
    
    while heap:
        current_cost, current_node = heapq.heappop(heap)
        
        if dist[current_node] < current_cost:
            continue
        
        for new_node in graph[current_node]:
            new_cost = current_cost + 1
            
            if new_cost < dist[new_node]:
                dist[new_node] = new_cost   
                heapq.heappush(heap, (new_cost, new_node))
    
    return dist

def solution(n, edge):
    # 1번 노드에서 가장 멀리 떨어진 노드의 개수
        # 가장 멀리 떨어진 노드: 최단 경로로 이동할 때 간선의 개수가 가장 많은 노드 -> 몇번 건너가냐?
    # 양방향 그래프
    # 간선의 cost 같을 때 최단 경로 구하기 -> 다익스트라 알고리즘
    
    # 1. Graph 만들기
    graph = [[] for _ in range(n + 1)]
    for a, b in edge:
        graph[a].append(b)
        graph[b].append(a)

    # 3. dist 배열에서 max count return
    
    dist = dijkstra(graph, n)[1:]
    target = max(dist)
    
    return dist.count(target)
