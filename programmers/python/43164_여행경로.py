def solution(tickets):
    '''
    1. 출발 공항을 key로 갖는 dict 생성
    2. 목적지는 알파벳 순서로 정렬
    3. ICN부터 DFS
    4. 티켓을 하나씩 사용하면서 모든 티켓을 사용했으면 종료
    '''

    ticket_dict = {}

    for start, end in tickets:
        if start not in ticket_dict:
            ticket_dict[start] = []

        ticket_dict[start].append([end, False])

    # 알파벳 순서로 방문하기 위해 정렬
    for start in ticket_dict:
        ticket_dict[start].sort(key=lambda x: x[0])

    answer = ["ICN"]

    def dfs(current, used_count):
        # 모든 티켓을 사용했으면 성공
        if used_count == len(tickets):
            return True

        # 현재 공항에서 출발하는 티켓이 없다면 실패
        if current not in ticket_dict:
            return False

        for ticket in ticket_dict[current]:
            destination, used = ticket

            if used:
                continue

            # 티켓 사용
            ticket[1] = True
            answer.append(destination)

            # 이후에도 모든 티켓을 사용할 수 있다면 성공
            if dfs(destination, used_count + 1):
                return True

            # 막혔다면 원상복구
            ticket[1] = False
            answer.pop()

        return False

    dfs("ICN", 0)

    return answer