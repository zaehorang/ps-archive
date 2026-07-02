def solution(numbers, target):
    n = len(numbers)
    
    def dfs(index, total):
        if index == n:
            return 1 if total == target else 0
        
        plus = dfs(index + 1, total + numbers[index])
        minus = dfs(index + 1, total - numbers[index])
        
        return plus + minus
    return dfs(0, 0)
