def solution(n, k):
    lamb_price = 12000
    drink_price = 2000
    service_count = 10
    
    count = n // service_count
    total_price = lamb_price * n + (k - count) * drink_price
    
    return total_price