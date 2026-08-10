def solution(s):
    transform_count = 0
    zero_count = 0

    while s != "1":
        one_count = s.count("1")
        zero_count += len(s) - one_count
        
        s = format(one_count, 'b')
        # s = bin(one_count)[2:]
        transform_count += 1

    return [transform_count, zero_count]