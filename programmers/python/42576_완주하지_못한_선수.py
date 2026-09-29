from collections import Counter

def solution(participant, completion):
#     count = {}
    
#     for name in participant:
#         count[name] = count.get(name, 0) + 1
    
#     for name in completion:
#         count[name] -= 1
    
#     for name, cnt in count.items():
#         if cnt > 0:
#             return name

    p_counter = Counter(participant)
    c_counter = Counter(completion)
    
    return list(p_counter - c_counter)[0]
    