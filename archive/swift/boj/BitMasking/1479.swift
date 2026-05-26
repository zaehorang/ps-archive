//
//  1479.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 12/22/25.
//  https://www.acmicpc.net/problem/1497
//

/*
 [틀린 풀이 과정에서의 실수]

 1) 비트마스크는 “정수값 크기”로 좋고 나쁨을 판단하면 안 됨
    - 목표는 가능한 곡 수 최대화 => `nonzeroBitCount`(1 비트 개수)로 비교해야 함
    - 예) 0b100000(1곡, 값 32) vs 0b011111(5곡, 값 31)
      -> 값 32가 더 크지만, 실제로는 5곡 가능한 31이 더 좋은 상태

 2) `bestSongCount <= songCount`로 '커짐(>)'과 '동률(==)'을 한 번에 처리하면 상태가 깨질 수 있음
    - songCount가 더 커진 경우(>)에는 새로운 최적해이므로 기타 수를 해당 조합으로 '교체'해야 함
    - 그런데 min(bestGuitarCount, guitarCount)를 같이 해버리면,
      이전(더 적은 곡을 치던 조합)의 기타 수가 남아 (bestSongCount, bestGuitarCount)가 불일치할 수 있음

 [정답 갱신 규칙]
   - if songCount > bestSongCount  : bestSongCount = songCount; bestGuitarCount = guitarCount
   - else if songCount == bestSongCount : bestGuitarCount = min(bestGuitarCount, guitarCount)

 (참고) `songBit == ((1 << M) - 1)`(모든 곡 가능)은 결국 songCount == M 케이스라서,
       위 규칙 하나로도 충분히 처리 가능
 */

// ⭐️ 조건문 구현 시, 적용 범위가 더 큰 조건(1차 최적화)을 먼저 분리해서 처리해야 한다.

func _1479() {
    let NM = readLine()!.split(separator: " ").map { Int($0)! }
    let (N, M) = (NM[0], NM[1])
    
    var guitars = [Int]()
    
    for _ in 0..<N {
        let info = readLine()!.split(separator: " ")
        let patter = Array(info[1])
        
        var mask = 0
        
        for i in 0..<M {
            if patter[i] == "Y" {
                mask |= (1 << i)
            }
        }
        
        guitars.append(mask)
    }
    
    var bestSongCount = 0
    var bestGuitarCount = Int.max
    
    for subset in 1..<(1 << N) {
        var played = 0
        var guitarCount = 0
        
        for j in 0..<N {
            if ((subset >> j) & 1) == 1 {
                played |= guitars[j]
                guitarCount += 1
            }
        }
        
        let songCount = played.nonzeroBitCount
        
        if songCount > bestSongCount {
            bestSongCount = songCount
            bestGuitarCount = guitarCount
        } else if songCount == bestSongCount {
            bestGuitarCount = min(bestGuitarCount, guitarCount)
        }
    }
    print(bestSongCount == 0 ? -1 : bestGuitarCount)
}

