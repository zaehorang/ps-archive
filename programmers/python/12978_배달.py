import heapq

def dijkstra(N, graph, start):
    INF = float('inf')
    dist = [INF] * (N + 1)
    dist[start] = 0

    heap = [(0, start)]

    while heap:
        current_dist, current_node = heapq.heappop(heap)

        if current_dist > dist[current_node]:
            continue

        for next_node, cost in graph[current_node]:
            new_dist = current_dist + cost

            if new_dist < dist[next_node]:
                dist[next_node] = new_dist
                heapq.heappush(heap, (new_dist, next_node))

    return dist


def solution(N, road, K):
    graph = [[] for _ in range(N + 1)]

    for a, b, c in road:
        graph[a].append((b, c))
        graph[b].append((a, c))

    dist = dijkstra(N, graph, 1)

    return sum(d <= K for d in dist[1:])