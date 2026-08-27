from collections import Counter

def solution(k, tangerine):
    dict_tangerine = Counter(tangerine)

    answer = 0
    c = k
    for n in sorted(dict_tangerine.values(), reverse=True):
        c -= n
        answer += 1
        if c <= 0:
            return answer
        