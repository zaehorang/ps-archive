def solution(fees, records):

    def split_DD(time_str):
        return list(map(int, time_str.split(":")))

    def cal_time(out_time, in_time):
        out_arr = out_time.copy()
        in_arr = in_time

        if out_arr[1] < in_arr[1]:
            out_arr[0] -= 1

            res_min = out_arr[1] + 60 - in_arr[1]
            res_h = out_arr[0] - in_arr[0]

            return [res_h, res_min]

        res_min = out_arr[1] - in_arr[1]
        res_h = out_arr[0] - in_arr[0]

        return [res_h, res_min]

    def cal_cost(accum_time):
        total_min = 60 * accum_time[0] + accum_time[1]

        if total_min <= fees[0]:
            return fees[1]

        cost = fees[1]

        # 기본 시간 제외
        total_min -= fees[0]

        # 올림
        cost += ((total_min + fees[2] - 1) // fees[2]) * fees[3]

        return cost

    record_dict = {}

    for elem in records:
        time, car, _ = elem.split()

        record_dict[car] = record_dict.get(car, [])
        record_dict[car].append(split_DD(time))

    ans = []

    for car_num, time_arr in sorted(record_dict.items()):

        cnt = len(time_arr)
        total_time = [0, 0]

        if cnt % 2 == 0:

            for _ in range(cnt // 2):
                out_t = time_arr.pop()
                in_t = time_arr.pop()

                parking_time = cal_time(out_t, in_t)

                total_time[0] += parking_time[0]
                total_time[1] += parking_time[1]

        else:
            # ⭐ 마지막 IN은 23:59 OUT 처리
            in_t = time_arr.pop()

            parking_time = cal_time([23, 59], in_t)

            total_time[0] += parking_time[0]
            total_time[1] += parking_time[1]

            # 나머지는 정상적인 IN / OUT 쌍
            for _ in range(cnt // 2):
                out_t = time_arr.pop()
                in_t = time_arr.pop()

                parking_time = cal_time(out_t, in_t)

                total_time[0] += parking_time[0]
                total_time[1] += parking_time[1]

        ans.append(cal_cost(total_time))

    return ans