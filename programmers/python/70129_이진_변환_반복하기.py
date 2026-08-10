def calculate_binary(n):
    return format(n, 'b')    
        
def remove_zero(str):
    zero_count = 0
    original = ""
    
    for char in str:
        if char == "0":
            zero_count += 1
        else:
            original += char
    return [original, zero_count]

def solution(s):
    binary_count = 0
    zero_count = 0
    
    copy = s
    
    # 1. if s == 1이 아니면, 
        # 0 제거 -> 0 제거 counting 
    # 1-1. 1이면 종료
    
    while copy != "1":
        new, n = remove_zero(copy)
        
        zero_count += n
        binary_count += 1
        
        copy = calculate_binary(len(new))
        
    # 2. 이진 변환 실행: len 계산; l -> s = l (이진수) (반복)
        # 다시 1로 loop
    
    
    # [이진 변환 횟수, 제거된 0의 개수]
    return [binary_count, zero_count]