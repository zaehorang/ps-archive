
'''
 N 극이 0 / S 극이 1
 자석을 회전시키는 방향은 
  빨간색 화살표 위치의 날부터 시계방향 순서
  
  붙어 있는 index
  2, 6
  
'''
T = int(input())
# 여러개의 테스트 케이스가 주어지므로, 각각을 처리합니다.
for test_case in range(1, T + 1):
    K = int(input())
    cogwheels = [list(map(int, input().split())) for _ in range(4)]
    start_index = [0, 0, 0, 0] # 1~4번 휠
    # 오른쪽 index + 2 &% 8
    # 왼쪽 index + 6 % 8
    def cogwheel_right_idx(n):
        return (start_index[n] + 2) % 8
    def cogwheel_left_idx(n):
        return (start_index[n] + 6) % 8
    
    def rotate_cogwheel(n, rotation, before):
        # 시계방향이 1 로, 반시계 방향이 -1 
        current_wheel = n
        right_wheel = n + 1
        left_wheel  = n - 1
        
        if right_wheel != before and right_wheel >= 0 and right_wheel < 4 and cogwheels[current_wheel][cogwheel_right_idx(current_wheel)] != cogwheels[right_wheel][cogwheel_left_idx(right_wheel)]:
            rotate_cogwheel(right_wheel, -(rotation), current_wheel)
            
        if left_wheel != before and left_wheel >= 0 and left_wheel < 4 and cogwheels[left_wheel][cogwheel_right_idx(left_wheel)] != cogwheels[current_wheel][cogwheel_left_idx(current_wheel)]:
            rotate_cogwheel(left_wheel, -(rotation), current_wheel)
        
        start_index[n] = (start_index[n] - (rotation) + 8) % 8
        
    
    for _ in range(K):
        n, rotation = map(int, input().split())
        n -= 1
        
        rotate_cogwheel(n, rotation, -1)
    
    answer = 0
    for i in range(4):
        if cogwheels[i][start_index[i]] == 1:
        	answer += 2 ** i
            
    print(f"#{test_case} {answer}")