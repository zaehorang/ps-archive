//
//  1679.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 4/29/24.
//  https://www.acmicpc.net/problem/1697

//func _1679() {
//
//    let nk = readLine()!.split(separator: " ").map { Int($0)! }
//
//    let n = nk[0]  // 수빈
//    let k = nk[1]  // 동생
//
//    var visitedArr: [Int] = .init(repeating: 0, count: 10000000)
//
//    var cnt = 0
//    var queue = [n]
//
//    visitedArr[n] = 1  // 방문 표시
//
//    var num = 3
//    var index = 3
//
//    var ans = 0
//
//    while !queue.isEmpty {
//        let a = queue.removeFirst()
//
//        if a != k {
//
//            for i in 0..<3 {
//                if i == 0 && visitedArr[a * 2] != 1 {
//                    queue.append(a * 2)
//                    visitedArr[a * 2] = 1
//                } else if i == 1 && visitedArr[a + 1] != 1 {
//                    queue.append(a + 1)
//                    visitedArr[a + 1] = 1
//                } else if i == 2 && (a - 1) >= 0 && visitedArr[a - 1] != 1 {
//                    queue.append(a - 1)
//                    visitedArr[a - 1] = 1
//                } else {
//
//                }
//
//                cnt += 1
//            }
//
//        } else {  // a == k
//
//            while cnt > num {
//                index *= 3
//                num += index
//                ans += 1
//            }
//
//            print(ans)
//            break
//        }
//
//    }
//
//}

//MARK: - Queue
struct IntQueue {
    private var datas: [Int?] = []
    
    private var head: Int = 0
    
    
    var isEmpty: Bool {
        datas.isEmpty
    }
    
    func queuePrint() {
        print(datas)
    }
    
    mutating func enqueue(_ elem: Int) {
        datas.append(elem)
    }
    
    mutating func dequeue() -> Int? {
        guard head < datas.count, let element = datas[head] else { return nil }
        datas[head] = nil
        
        head += 1  // head를 증가시켜 다음 요소로 이동
        
        let percentage = Double(head) / Double(datas.count)
        
        // head가 배열의 앞부분에 요소가 많이 남아있으면 배열을 정리
        if percentage > 0.25 && head > 50 {
            datas.removeFirst(head)
            head = 0
        }
        return element
    }
    
    mutating func removeAll() {
        datas.removeAll()
        head = 0
    }
}


func _1679() {
    
    let nk = readLine()!.split(separator: " ").map { Int($0)! }
    
    let n = nk[0]  // 수빈
    let k = nk[1]  // 동생
    
    // ❗️-1로 넣는 이유 -> n의 초기 값이 0이 들어오면 중복을 제거하지 못한다.
    var arr: [Int] = .init(repeating: -1, count: 200003)
    
    var queue = IntQueue()
    queue.enqueue(n)
    arr[n] = 0
 
    while !queue.isEmpty {
        guard let a = queue.dequeue() else { break }
        
        if a != k {
            
            let i = a * 2
            let j = a + 1
            let k = a - 1
            
            if i <= 200000 && arr[i] == -1 {
                arr[i] = arr[a] + 1
                queue.enqueue(i)
            }

            if j <= 200000 && arr[j] == -1  {
                arr[j] = arr[a] + 1
                queue.enqueue(j)
            }

            
            if k >= 0 && arr[k] == -1 {
                queue.enqueue(k)
                arr[k] = arr[a] + 1
            }
            
        } else {
            print(arr[a])
            break
        }
        
    }
    
    
}

