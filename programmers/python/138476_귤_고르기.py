from collections import Counter

def solution(k, tangerine):
    count_tangerine = Counter(tangerine)

    answer = 0
    c = k
    for _, value in count_tangerine.most_common():
        c -= value
        answer += 1
        if c <= 0:
            return answer
        