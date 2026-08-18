offsets = [-2, -1, 1, 2]

for test_case in range(1, 11):
    n = int(input())
    buildings = list(map(int, input().split()))

    answer = 0

    for idx in range(2, n - 2):
        height = buildings[idx]

        max_neighbor = max(
            buildings[idx + offset]
            for offset in offsets
        )

        if height > max_neighbor:
            answer += height - max_neighbor

    print(f"#{test_case} {answer}")