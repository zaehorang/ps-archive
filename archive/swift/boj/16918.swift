//
// 16918.swift
// Swift_Algorithm
//
// Created by zaehorang on 2026/2/20.
// https://acmicpc.net/problem/16918
//

import Foundation

/*

 사고 흐름 기록 (다음에 비슷한 문제에서 바로 떠올리기 위한 메모)

 ✅ 내가 처음 했던 생각(틀린 가정)
 - "짝수 초에는 항상 격자가 폭탄(O)으로 꽉 찬다"를 보고,
   1초(초기) ↔ 3초(폭발 결과) ↔ 꽉 찬 상태(짝수) 가 반복될 거라고 추측했다.
 - 특히 손으로 몇 케이스를 그리다 보면 우연히 1초 == 5초가 되는 경우(대칭/희소)가 자주 보여서
   "그럼 1초도 주기 안에 들어가나?"라고 착각하기 쉬웠다.

 ❌ 왜 이 추측이 위험했나(핵심 원인)
 - 이 문제의 상태는 겉으로 보이는 O/. 뿐 아니라 "폭탄의 나이(설치 시점)"가 숨어 있다.
 - 1초의 폭탄들은 '이미 설치되어 있던 것'이라 3초에 바로 터지는 특수 입력이고,
   2초에 새로 깔린 폭탄들과는 '같은 O'라도 의미가 다르다.
 - 즉, 1초를 주기 후보로 섣불리 포함하면, 대칭/희소 케이스에서만 성립하는 착시에 속기 쉽다.

 ✅ 다르게 생각했어야 하는 흐름(사고 절차)
 1) 앵커(무조건 고정되는 시점)부터 잡기
    - 짝수 초(2,4,6,...)는 항상 "전부 O"로 동일하다.
    - 따라서 분석은 홀수 초들(1,3,5,7,...)만 보면 된다.

 2) 홀수 → 다음 홀수 로 가는 전이(transition)를 한 번에 정의하기
    - 홀수 상태 B가 주어졌을 때, 다음 홀수는
      F(B) = "전부 O"에서, B에 있던 폭탄 위치 + 상하좌우를 '.'로 지운 결과
    - 짝수 초가 항상 full이기 때문에, 폭탄의 '나이' 문제를 전이 함수 F로 흡수할 수 있다.

 3) 최소 F를 두 번 적용해서 '진짜 주기'를 확인하기
    - 3초 = S3 = F(S1)
    - 5초 = S5 = F(S3) = F(F(S1))
    - 3초 이후 홀수 시간은 S3 ↔ S5 두 상태가 번갈아 반복된다 (4초 주기).
      (…3,7,11…은 S3 / …5,9,13…은 S5)

 4) 관찰(예시 몇 개)로 결론 내리지 말고, 반례를 '적대적으로' 만들기
    - 대칭/희소(중앙 1개 같은) 입력은 1초==5초 착시가 잘 생긴다.
    - 가설을 깨려면 비대칭/밀집/경계 포함 케이스로 빠르게 반례를 만든다.

 ※ 결론: "반복이 보이면" 1초를 포함하는지부터 믿지 말고,
          F(F)까지(=5초까지) 확인해서 주기(두 상태 교대)를 확정한다.
*/

func _16918() {
    // Your solution here
    let rcn = readLine()!.split(separator: " ").compactMap { Int($0) }
    let r = rcn[0], c = rcn[1], n = rcn[2]
    
    let all:[[String]] = .init(repeating: .init(repeating: "O", count: c), count: r)

    var elems: [(Int, Int)] = []
    var first: [[String]] = []
    
    for i in 0..<r {
        let row = readLine()!.map { String($0) }
        first.append(row)
        
        for j in 0..<c { if row[j] == "O" { elems.append((i, j))} }
    }
    
    if n % 2 == 0 {
        var ans = ""
        for row in all {
            ans += "\(row.joined(separator: ""))\n"
        }
        print(ans)
        return
    } else if n == 1 {
        var ans = ""
        for row in first {
            ans += "\(row.joined(separator: ""))\n"
        }
        print(ans)
        return
    }
    
    
    var second = all
    
    let dx = [0, 1, 0, -1]
    let dy = [1, 0, -1, 0]
    
    for (i, j) in elems {
        second[i][j] = "."
        for d in 0..<4 {
            let nx = dx[d] + i
            let ny = dy[d] + j
            
            guard nx >= 0 && nx < r else { continue }
            guard ny >= 0 && ny < c else { continue }
            
            second[nx][ny] = "."
        }
    }
    
    var third = all
    
    for i in 0..<r {
        for j in 0..<c {
            if second[i][j] == "O" {
                third[i][j] =  "."
                
                for d in 0..<4 {
                    let nx = dx[d] + i
                    let ny = dy[d] + j
                    
                    guard nx >= 0 && nx < r else { continue }
                    guard ny >= 0 && ny < c else { continue }
                    
                    third[nx][ny] = "."
                }
            }
        }
    }
    
    var ans = ""
    let remainder = n % 4
    
    if remainder == 1 {
        for row in third {
            ans += "\(row.joined(separator: ""))\n"
        }
    } else if remainder == 3 {
        for row in second {
            ans += "\(row.joined(separator: ""))\n"
        }
    }
    
    print(ans)
}
