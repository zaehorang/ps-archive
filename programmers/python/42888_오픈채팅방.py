def solution(record):
    """
    1. user_info:
       user_id -> 최종 nickname

    2. logs:
       실제 출력이 필요한 Enter / Leave 이벤트만 순서대로 저장

    Change는 출력 이벤트가 아니므로 user_info만 갱신한다.
    마지막에 최종 nickname을 이용해 전체 메시지를 생성한다.
    """

    user_info = {}
    logs = []

    for record_item in record:
        data = record_item.split()

        action = data[0]
        user_id = data[1]

        if action == "Enter":
            nickname = data[2]

            user_info[user_id] = nickname
            logs.append((user_id, action))

        elif action == "Leave":
            logs.append((user_id, action))

        else:  # Change
            nickname = data[2]
            user_info[user_id] = nickname

    answer = []

    for user_id, action in logs:
        nickname = user_info[user_id]

        if action == "Enter":
            answer.append(f"{nickname}님이 들어왔습니다.")
        else:
            answer.append(f"{nickname}님이 나갔습니다.")

    return answer