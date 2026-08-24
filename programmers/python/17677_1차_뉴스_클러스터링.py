from collections import Counter

def solution(str1, str2):
    '''
    [자카드 유사도]
    J(A, B) = 교집합 크기 / 합집합 크기

    - 두 집합이 모두 공집합이면 J = 1
    - 최종 결과는 J * 65536 후 소수점 이하 버림


    [문자열 처리]
    1. 대소문자를 구분하지 않음
    2. 문자열을 두 글자씩 끊어서 다중집합 생성
    3. 두 문자 모두 영문자(a~z)인 경우에만 사용


    [다중집합]
    일반 set은 중복을 제거하기 때문에 사용할 수 없음.

    ex)
    A = ["aa", "aa", "bb"]
    B = ["aa", "aa", "aa"]

    "aa"의
    - 교집합 개수 = min(2, 3) = 2
    - 합집합 개수 = max(2, 3) = 3

    따라서 각 원소의 등장 횟수를 저장하는 Counter 사용.


    [Counter의 &, |]
    Python은 연산자 오버로딩을 지원하기 때문에
    자료형에 따라 &, |의 동작이 다르게 정의되어 있다.

    int:
        & -> 비트 AND
        | -> 비트 OR

    set:
        & -> 교집합
        | -> 합집합

    Counter:
        & -> 같은 key의 count 중 min
        | -> 같은 key의 count 중 max

    따라서 Counter에서는
        counter1 & counter2 -> 다중집합의 교집합
        counter1 | counter2 -> 다중집합의 합집합
    '''

    def make_counter(s):
        # 대소문자를 구분하지 않으므로 소문자로 통일
        s = s.lower()

        # 문자열을 두 글자씩 확인하면서 Counter 생성
        #
        # s[i:i + 2]를 사용해 두 글자 문자열 생성
        #
        # ord()로 ASCII 값을 직접 비교할 수도 있지만
        # Python에서는 문자 자체의 대소 비교가 가능하므로
        # 'a' <= 문자 <= 'z' 형태로 확인할 수 있다.
        #
        # 두 문자 모두 영문자인 경우에만 Counter에 추가
        return Counter(
            s[i:i + 2]
            for i in range(len(s) - 1)
            if 'a' <= s[i] <= 'z'
            and 'a' <= s[i + 1] <= 'z'
        )

    # 두 문자열을 다중집합으로 변환
    counter1 = make_counter(str1)
    counter2 = make_counter(str2)

    # Counter의 &
    # -> 동일 key의 등장 횟수 중 min
    # -> 다중집합의 교집합
    #
    # values()는 각 원소의 등장 횟수를 반환하므로
    # sum()을 통해 교집합의 전체 원소 개수를 구한다.
    intersection_count = sum((counter1 & counter2).values())

    # Counter의 |
    # -> 동일 key의 등장 횟수 중 max
    # -> 다중집합의 합집합
    union_count = sum((counter1 | counter2).values())

    # 두 다중집합이 모두 공집합이면
    # 문제 조건에 따라 자카드 유사도 = 1
    if union_count == 0:
        return 65536

    # 자카드 유사도
    # 교집합 / 합집합 * 65536
    #
    # int((intersection / union) * 65536)처럼
    # 실수 연산을 할 필요 없이,
    # //를 사용하면 정수 연산만으로 소수점 이하를 버릴 수 있다.
    return intersection_count * 65536 // union_count