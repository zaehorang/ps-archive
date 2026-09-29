def solution(record):
    '''
    중복 닉네임 가능
    나가서 닉네임 바꾸고 들어오면 이전 기록도 바뀜
    
    상태를 두는 db 느낌 자료구조를 두고..
    result 상태에 유저 아이디로 쌓아두고 나중에 최종 db 상태로 갱싱해서 return 하면 될 듯 ?
    
    data structure
    user_id: nickname / status
    
    입장 순서도 중요
        enter / leave는 순서를 유지
    
    '''
    # id, status
    result_list = []
    user_info = {}
    
    def update_user(user_id, nickname):
        nonlocal user_info
        
        user_info[user_id] = nickname
    
    # 1. record 분석 method
    def check_record(str):
        # Enter / Leave / Change
        record_arr = str.split()
        
        action = record_arr[0]
        user_id = record_arr[1]
        
        if action == "Enter":
            nickname = record_arr[2]
            update_user(user_id, nickname)
            
            result_list.append((user_id, action))
        elif action == "Leave":
            result_list.append((user_id, action))
        else:
            # Change
            nickname = record_arr[2]
            update_user(user_id, nickname)
        
    
    for reco in record:
        check_record(reco)
    
    answer = []
    for result in result_list:
        user_id = result[0]
        status = result[1]
        
        if status == "Enter":
            answer.append(f"{user_info[user_id]}님이 들어왔습니다.")
        else:
            answer.append(f"{user_info[user_id]}님이 나갔습니다.")
    
    return answer