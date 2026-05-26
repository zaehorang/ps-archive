arr = [False] * 31

for i in range(28):
    arr[int(input())] = True

for i in range(1, 31):
    if arr[i]:
        continue
    print(i)
