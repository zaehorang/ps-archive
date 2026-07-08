import heapq

class Solution:
    def networkDelayTime(self, times: List[List[int]], n: int, k: int) -> int:
        # 노드는 1번부터 n번까지 존재한다.
        # times는 (start, end, cost) 형태의 단방향 가중치 엣지이다.
        #
        # k번 노드에서 신호를 보냈을 때 모든 노드가 신호를 받는 최소 시간을 구한다.
        # 모든 노드가 신호를 받을 수 없다면 -1을 반환한다.
        #
        # 간선 비용이 모두 같지 않으므로 BFS가 아니라 Dijkstra를 사용한다.
        # 시작점 k에서 모든 노드까지의 최단 시간을 구한 뒤,
        # 그중 가장 큰 값이 전체 네트워크에 신호가 퍼지는 시간이다.

        graph = [[] for _ in range(n + 1)]

        for start, end, cost in times:
            graph[start].append((cost, end))

        dist = self.dijkstra(graph, n, k)

        answer = max(dist[1:])

        return -1 if answer == float('inf') else answer

    def dijkstra(self, graph, n, k):
        # 시작 노드 k에서 모든 노드까지의 최단 시간을 구한다.
        INF = float('inf')
        dist = [INF] * (n + 1)
        dist[k] = 0

        # heap에는 (현재까지의 비용, 현재 노드)를 저장한다.
        heap = [(0, k)]

        while heap:
            current_cost, current_node = heapq.heappop(heap)

            # heap에 남아 있는 오래된 경로라면 무시한다.
            # break가 아니라 continue를 써야 한다.
            if current_cost > dist[current_node]:
                continue

            for cost, next_node in graph[current_node]:
                new_cost = current_cost + cost

                if new_cost < dist[next_node]:
                    dist[next_node] = new_cost
                    heapq.heappush(heap, (new_cost, next_node))

        return dist