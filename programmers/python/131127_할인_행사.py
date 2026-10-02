def solution(want, number, discount):
    window_size = sum(number)

    products = set(want + discount)

    def make_count_dict():
        return {product: 0 for product in products}

    # 원하는 상품 개수
    target_count = make_count_dict()

    for i in range(len(want)):
        target_count[want[i]] = number[i]

    # 첫 번째 window
    window_count = make_count_dict()

    for i in range(window_size):
        window_count[discount[i]] += 1

    answer = 0

    if window_count == target_count:
        answer += 1

    # sliding window
    for current_idx in range(window_size, len(discount)):
        before_idx = current_idx - window_size

        window_count[discount[current_idx]] += 1
        window_count[discount[before_idx]] -= 1

        if window_count == target_count:
            answer += 1

    return answer