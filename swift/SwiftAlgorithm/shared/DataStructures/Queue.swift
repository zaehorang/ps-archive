//
//  Queue.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 5/1/24.
//

//MARK: - Queue
struct Queue<T> {
    private var datas: [T?] = []
    
    private var head: Int = 0
    
    
    var isEmpty: Bool {
        datas.isEmpty
    }
    
    func queuePrint() {
        print(datas)
    }
    
    mutating func enqueue(_ elem: T) {
        datas.append(elem)
    }
    
    mutating func dequeue() -> T? {
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
