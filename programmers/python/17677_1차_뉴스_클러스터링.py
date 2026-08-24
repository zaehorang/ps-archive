from collections import Counter

def solution(str1, str2):
    '''
    [자카드 유사도]
    J(A, B) = 교집합 크기 / 합집합 크기

    - 둘 다 공집합이면 J = 1
    - 최종 결과는 J * 65536 후 소수점 버림

    [문자열 처리]
    1. 대소문자를 구분하지 않음
    2. 문자열을 두 글자씩 끊음
    3. 두 문자 모두 영문자인 경우에만 사용

    [다중집합]
    일반 set과 달리 중복 원소의 개수를 유지해야 함.
    ex)
    A = ["aa", "aa", "bb"]
    B = ["aa", "aa", "aa"]

    "aa"의
    - 교집합 개수 = min(2, 3) = 2
    - 합집합 개수 = max(2, 3) = 3

    따라서 Counter를 사용한다.

    [Counter의 &, |]
    Python은 연산자 오버로딩을 지원한다.
    타입마다 &, |에 대한 내부 동작이 다르게 정의될 수 있다.

    int:
        & -> 비트 AND
        | -> 비트 OR

    set:
        & -> 교집합
        | -> 합집합

    Counter:
        & -> 같은 key의 count 중 min
        | -> 같은 key의 count 중 max

    즉 Counter에서
        counter1 & counter2 -> 다중집합의 교집합
        counter1 | counter2 -> 다중집합의 합집합
    '''

    # 영문 소문자의 ASCII 범위
    a_ord = ord('a')  # 97
    z_ord = ord('z')  # 122

    def make_list(s):
        # 대소문자를 구분하지 않으므로 모두 소문자로 변환
        s = s.lower()

        result = []

        # 두 글자씩 확인
        for idx in range(len(s) - 1):
            first = s[idx]
            second = s[idx + 1]

            # 두 문자 모두 a~z 사이인지 확인
            if not (a_ord <= ord(first) <= z_ord):
                continue

            if not (a_ord <= ord(second) <= z_ord):
                continue

            result.append(first + second)

        return result

    # Counter를 사용해 각 두 글자 조합의 등장 횟수 저장
    str1_counter = Counter(make_list(str1))
    str2_counter = Counter(make_list(str2))

    # Counter의 &
    # -> 같은 원소의 등장 횟수 중 min
    # -> 다중집합의 교집합
    intersection = str1_counter & str2_counter

    # Counter의 |
    # -> 같은 원소의 등장 횟수 중 max
    # -> 다중집합의 합집합
    union = str1_counter | str2_counter

    # Counter.values()에는 각 원소의 등장 횟수가 들어있으므로
    # 모두 더하면 다중집합의 전체 원소 개수가 된다.
    intersection_count = sum(intersection.values())
    union_count = sum(union.values())

    # 둘 다 공집합이면 자카드 유사도 = 1
    if union_count == 0:
        return 65536

    # 자카드 유사도 = 교집합 / 합집합
    # int()를 통해 소수점 이하 버림
    return int((intersection_count / union_count) * 65536)