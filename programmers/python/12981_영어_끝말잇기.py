def solution(n, words):
    '''
    끝말잇기 탈락 조건
    1. 이전에 등장한 단어를 다시 말한 경우
    2. 이전 단어의 마지막 글자와 현재 단어의 첫 글자가 다른 경우

    중복 체크 -> set 사용 (O(1))

    idx는 0부터 시작하므로
    사람 번호 = idx % n + 1
    차례     = idx // n + 1

    끝까지 탈락자가 없으면 [0, 0]
    '''

    # 첫 단어는 이미 사용한 것으로 처리
    used_words = {words[0]}

    # 첫 단어는 검사할 필요가 없으므로 두 번째부터 시작
    for idx in range(1, len(words)):
        word = words[idx]
        prev_word = words[idx - 1]

        # 중복 단어이거나 끝말잇기가 성립하지 않는 경우
        if word in used_words or prev_word[-1] != word[0]:
            return [idx % n + 1, idx // n + 1]

        used_words.add(word)

    return [0, 0]