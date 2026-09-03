def solution(fees, records):
    '''
    1. 차량별 입출차 시간을 저장한다.
    2. 차량별로 전체 주차 시간을 누적한다.
    3. 누적 주차 시간에 대해 요금을 한 번만 계산한다.
    4. 차량 번호가 작은 순서대로 요금을 반환한다.
    '''

    # "05:34" -> [5, 34]
    def split_time(time_str):
        return list(map(int, time_str.split(":")))

    # 출차 시간 - 입차 시간
    # 결과: [시간, 분]
    def cal_time(out_time, in_time):
        # 원본 리스트를 직접 수정하지 않기 위해 copy
        out_arr = out_time.copy()
        in_arr = in_time

        # 출차 분이 입차 분보다 작으면
        # 시간에서 1시간 빌려온다.
        # ex) 10:20 - 09:50
        if out_arr[1] < in_arr[1]:
            out_arr[0] -= 1

            res_min = out_arr[1] + 60 - in_arr[1]
            res_h = out_arr[0] - in_arr[0]

            return [res_h, res_min]

        # 일반적인 경우
        res_min = out_arr[1] - in_arr[1]
        res_h = out_arr[0] - in_arr[0]

        return [res_h, res_min]

    # 누적 주차 시간 [h, m]을 받아서 최종 요금 계산
    def cal_cost(accum_time):
        # 전체 시간을 분으로 변환
        total_min = 60 * accum_time[0] + accum_time[1]

        # 기본 시간 이하라면 기본 요금만 부과
        if total_min <= fees[0]:
            return fees[1]

        # 기본 요금
        cost = fees[1]

        # 기본 시간을 제외한 초과 시간만 계산
        total_min -= fees[0]

        # 초과 시간을 단위 시간으로 나눈 뒤 올림
        # ex) 31분 / 30분 단위 -> 2번 부과
        cost += ((total_min + fees[2] - 1) // fees[2]) * fees[3]

        return cost

    # 차량별 입출차 기록 저장
    # key: 차량 번호
    # value: [[입차시간], [출차시간], ...]
    record_dict = {}

    for elem in records:
        time, car, _ = elem.split()

        record_dict[car] = record_dict.get(car, [])
        record_dict[car].append(split_time(time))

    ans = []

    # 차량 번호가 작은 순서대로 처리
    for car_num, time_arr in sorted(record_dict.items()):

        cnt = len(time_arr)

        # 차량의 전체 누적 주차 시간
        total_time = [0, 0]

        # 기록 개수가 짝수
        # 모든 IN에 대응되는 OUT이 존재
        if cnt % 2 == 0:

            for _ in range(cnt // 2):
                # 뒤에서부터 보면
                # OUT -> IN 순서로 꺼내진다.
                out_t = time_arr.pop()
                in_t = time_arr.pop()

                parking_time = cal_time(out_t, in_t)

                # 요금을 바로 계산하지 않고
                # 주차 시간을 먼저 누적한다.
                total_time[0] += parking_time[0]
                total_time[1] += parking_time[1]

        # 기록 개수가 홀수
        # 마지막 IN에 대응되는 OUT이 없는 경우
        else:
            # 마지막 기록은 무조건 IN
            # 따라서 먼저 꺼내서 23:59 출차 처리
            in_t = time_arr.pop()

            parking_time = cal_time([23, 59], in_t)

            total_time[0] += parking_time[0]
            total_time[1] += parking_time[1]

            # 나머지 기록은 정상적인 IN / OUT 쌍
            for _ in range(cnt // 2):
                out_t = time_arr.pop()
                in_t = time_arr.pop()

                parking_time = cal_time(out_t, in_t)

                total_time[0] += parking_time[0]
                total_time[1] += parking_time[1]

        # ⭐ 모든 주차 시간을 합친 뒤
        # 요금을 딱 한 번 계산한다.
        ans.append(cal_cost(total_time))

    return ans