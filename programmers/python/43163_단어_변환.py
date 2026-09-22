def solution(begin, target, words):
    '''
    1. 한 번에 한 개 알파벳만 가능
    2. words에 있는 단어로 바꿈
    
    - 모든 단어 길이 같음
    - 소문자
    
    3 <= words <= 50
    
    - 변환 불가 0
    
    Solution
    1. begin이 바뀔 수 있는 건 정해져 있음
    
        - 기준 단어로 갈 수 있는 곳 찾기
        - 반복?
            - visited 관리?
            - dfs 파라미터로 계속 들고가?
    
    
    '''
    def can_go(a, b):
        cnt = 0
        
        for i in range(len(a)):
            if a[i] != b[i]:
                cnt += 1
        
        if cnt == 1:
            return True
        
        return False
    
    def find_idx_candidates(str):
        idx_arr = []
        
        for idx in range(len(words)):
            word = words[idx]
            if can_go(str, word):
                idx_arr.append(idx)
        return idx_arr
    
    
    words_count = len(words)
    
    answer = 100
    
    def dfs(str, before_idx_arr):
        nonlocal answer
        
        if len(before_idx_arr) == words_count:
            return
        if str == target:
            answer = min(answer, len(before_idx_arr))
            return 
        
        for idx in find_idx_candidates(str):
            if idx in before_idx_arr:
                continue
                
            new_before_idx_arr = before_idx_arr.copy()
            new_before_idx_arr.append(idx)

            dfs(words[idx], new_before_idx_arr)
    
    dfs(begin, [])
    
    if answer == 100:
        return 0
    return answer











