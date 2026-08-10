def solution(s):
    transform_count = 0
    zero_count = 0

    while s != "1":
        one_count = s.count("1")
        zero_count += len(s) - one_count
        
        s = format(one_count, 'b')
        # s = bin(one_count)[2:] // 0b111
        transform_count += 1

    return [transform_count, zero_count]

'''
binary string 직접 구하는 방식.

10진수 숫자
   ↓
2로 나눈다
   ↓
나머지(0 또는 1)를 저장한다
   ↓
몫을 다시 2로 나눈다
   ↓
몫이 0이 될 때까지 반복
   ↓
저장한 나머지를 역순으로 읽는다
   ↓
2진수 완성
'''