# SolveSync regression test - problem 1859
# Verifies that a different problem on the same URL syncs correctly.


def main():
    total_cases = int(input())
    for case_number in range(1, total_cases + 1):
        days = int(input())
        prices = list(map(int, input().split()))
        best = 0
        profit = 0
        for price in reversed(prices):
            if price > best:
                best = price
            else:
                profit += best - price
        print('#' + str(case_number) + ' ' + str(profit))


main()
