def solution(numbers, target):
    count = len(numbers)
    
    def recursion(index, current):
        if index >= count:
            if current == target:
                return 1
            return 0
        
        plus = recursion(index + 1, current + numbers[index])
        minus = recursion(index + 1, current - numbers[index])
        
        return plus + minus
        
    return recursion(0, 0)
