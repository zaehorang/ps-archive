def solution(numbers, target):
    count = len(numbers)
    answer = 0
    
    def recursion(index, current):
        nonlocal answer
        
        if index >= count:
            if current == target:
                answer += 1
            return
        
        recursion(index + 1, current + numbers[index])
        recursion(index + 1, current - numbers[index])
    
    recursion(0, 0)
    
    return answer