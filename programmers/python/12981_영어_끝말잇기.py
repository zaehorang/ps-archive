def solution(n, words):

    '''
    중복처리 -> Set
    
    [번호, 차례]
    탈락자 없을 수 있음 return [0, 0]
    
    끝말잇기가 되는지도 판다.
    '''
    
    duplicates = set()
    location = 0
    
    # 첫 단어의 시작
    before = words[0][0]
    
    for idx in range(len(words)):
        word = words[idx]
        
        if not word in duplicates:
            # 끝말잇기 성립 안되면
            if before[-1] != word[0]:
                print(before[-1])
                print(word[0])
                location = idx
                break
            duplicates.add(word)
            before = word
        else:
            # 1번부터 시작
            location = idx
            break
    
    if location == 0:
        return [0, 0]
    else:
        location += 1
        number = location % n
        
        if number == 0:
            number = n
            
    return [number, (location + n - 1) // n]
        
                
    
    