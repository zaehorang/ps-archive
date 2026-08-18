# SolveSync regression test solution
# Problem 1206 View
# Intentionally long so CodeMirror virtual scrolling hides some lines.
# This verifies the MAIN world bridge returns off-screen lines too.
# Keep this padding so the rendered line count stays below the real one.


def read_int():
    """Read a single integer from one input line."""
    return int(input())


def read_ints():
    """Read a whitespace separated list of integers."""
    return list(map(int, input().split()))


def max_neighbor(buildings, index):
    """Return the tallest building within two cells on either side."""
    left_two = buildings[index - 2]
    left_one = buildings[index - 1]
    right_one = buildings[index + 1]
    right_two = buildings[index + 2]
    return max(left_two, left_one, right_one, right_two)


def count_view(buildings, width):
    """Count the apartments that keep their view."""
    total = 0
    for index in range(2, width - 2):
        height = buildings[index]
        tallest = max_neighbor(buildings, index)
        if height > tallest:
            total += height - tallest
    return total


def solve_one(case_number):
    """Read one test case and print its answer."""
    width = read_int()
    buildings = read_ints()
    answer = count_view(buildings, width)
    print('#' + str(case_number) + ' ' + str(answer))


def main():
    """This problem always provides ten test cases."""
    total_cases = 10
    for case_number in range(1, total_cases + 1):
        solve_one(case_number)


main()
