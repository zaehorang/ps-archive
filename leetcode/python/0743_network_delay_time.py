import heapq

class Solution:
    def networkDelayTime(self, times: List[List[int]], n: int, k: int) -> int:
        # 1 ~ n 개 노드
        # (start, end, cost) 단뱡향 엣지
        # k 노드에서 신호 보내서 모든 신호가 수신하는데 걸리는 최소 시간
        # 다 못가면 retur -1

        # 시작점 정해짐, 걸리는 시간이 다 다르기 때문에 bfs로 최대값 구하기에는 다른 경로로 업데이트되어 최대 값이 바뀌는 시간이 있을 수 있음
        # dijkstra algorithm으로 시작점 기준 모든 노드에 최소 시간 구하고 거기서 최대값 리턴
        # if: 도착 시간 갱신 안된 노드 있으념 return -1

        # 1. Make graph
        graph = [[] for _ in range(n + 1)]
        for (st, des, time) in times:
            graph[st].append((time, des))

        dist = self.dijkstra(graph, n, k)

        # 3. Find minimum time
        target = max(dist)
        print(dist)
        if target == float('inf'):
            return -1

        return target
        
    # 2. Dijkstra Function  - return dist list
    def dijkstra(self, graph, n, k):
        INF = float('inf')
        dist = [INF] * (n + 1)

        dist[0] = 0
        dist[k] = 0

        # 시작점 K
        heap = [(0, k)]

        while heap:
            current_cost, current_node = heapq.heappop(heap)
            if current_cost > dist[current_node]:
                continue
            
            for cost, des in graph[current_node]:
                new_cost = current_cost + cost

                if new_cost < dist[des]:
                    dist[des] = new_cost
                    heapq.heappush(heap, (new_cost, des))

        return dist
        

