def solution(n, a, b):
    '''
    매 라운드가 끝나면 참가 번호는 다음과 같이 변경된다.

    1, 2 -> 1
    3, 4 -> 2
    5, 6 -> 3
    ...

    즉,
    next = (current + 1) // 2

    A와 B가 같은 번호가 되는 순간,
    바로 이전 라운드에서 서로 대결한 것이다.

    참가자 수는 매 라운드 절반으로 줄어드므로
    시간복잡도: O(log n)
    '''

    round_count = 0

    while a != b:
        a = (a + 1) // 2
        b = (b + 1) // 2
        round_count += 1

    return round_count