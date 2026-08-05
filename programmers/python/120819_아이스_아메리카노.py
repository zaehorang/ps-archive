def solution(money):
    count = money // 5500
    change = money % 5500
    return [count, change]