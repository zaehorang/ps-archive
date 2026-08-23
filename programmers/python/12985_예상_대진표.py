def solution(n,a,b):
    '''
    부전승 x
    n: 2~2^20  --> O(n)으로 생각하면 10^6 정도?
    
    결국 이기면 
    대진 그룹 flow
    
    1, 2 -> 1
    3, 4 -> 2
    5, 6 -> 3
    ...

    => +1, // 2
    '''
    

    answer = 1
    a_group = a
    b_group = b
    
    def next_group(batch):
        return (batch + 1) // 2
    
    while True:
        a_next_group = next_group(a_group)
        b_next_group = next_group(b_group)
        
        if a_next_group == b_next_group:
            return answer
        else:
            a_group = a_next_group
            b_group = b_next_group
            answer += 1
        