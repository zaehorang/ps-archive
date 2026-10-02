def solution(want, number, discount):
    '''
    10일 회원
    하루 하나씩 구매
    
    10일 연속 일치하는 경우 회원가입
    
    Return
        - 모두 할인 받을 수 있는 회원 등록 날짜의 총 일수
        - 불가능 -> 0
    
    number를 window size로 해당하는 물품이 나온 개수를 더하고, 빼고 기록
    number랑 같을 때 result..?
    
        - 계속 비교하면 10^6 번 정도
        
    dictionary로 카운트 해서 [want: number]랑 같은지를 매번 비교하면 비효율인가
    '''
    total = sum(number)
    
    products = set(want + discount)
    
    def make_init_dict():
        d = {}
        for product in products:
            d[product] = 0
    
        return d
    
    # want: count
    check_dict = make_init_dict()
    
    # make first window
    for i in range(total):
        prod = discount[i]
        check_dict[prod] = check_dict.get(prod, 0) + 1
    
    # make answer dict
    ans_dict = make_init_dict()
    for i in range(len(want)):
        prod = want[i]
        ans_dict[prod] = number[i]

    ans = 0
    
    # Compare dict
    def is_same_dicts(a, b):
        nonlocal ans
        
        if check_dict == ans_dict:
            ans += 1
    
    is_same_dicts(check_dict, ans_dict)
    
    for current_idx in range(total, len(discount)):
        before_idx = current_idx - total
        
        current_prod = discount[current_idx]
        check_dict[current_prod] = check_dict.get(current_prod, 0) + 1
        
        before_prod = discount[before_idx]
        check_dict[before_prod] -= 1
        
        is_same_dicts(check_dict, ans_dict)
        
    return ans