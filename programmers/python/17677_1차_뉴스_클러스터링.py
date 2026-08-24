from collections import Counter

def solution(str1, str2):
    '''
    J : 두 집합의 교집함 크기를 합집합 크기로 나눈 값
    공집합일 경우 J = 1
    
    min: 같은 값 개수 최소
    max: 같음 값 개수 최대
    
    대소문자 무시
    글자쌍만 가능
    '''
    a_ord = ord('a')
    z_ord = ord('z')
    
    def make_list(str):
        lower_str = str.lower()
        list_set = []
        
        for idx in range(len(str) - 1):
            first = lower_str[idx]
            second = lower_str[idx+1]
            
            ord_first = ord(first)
            ord_second = ord(second)
            
            if a_ord > ord_first or ord_first > z_ord:
                continue
            if a_ord > ord_second or ord_second > z_ord:
                continue
            
            list_set.append(first+second)
        
        return list_set
    
    str1_counter = Counter(make_list(str1))
    str2_counter = Counter(make_list(str2))
    
    
    union_count = sum((str1_counter | str2_counter).values())
    intersection_count = sum((str1_counter & str2_counter).values())

    # 둘 다 공집합인 경우 J = 1
    if union_count == 0:
        return 65536

    return int((intersection_count / union_count) * 65536)