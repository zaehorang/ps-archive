//
//  main.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 4/4/24.
//  https://www.acmicpc.net/problem/1406

//MARK: - Linkde List
class Node {
    let data: String?
    var prev: Node?
    var next: Node?
    
    init(data: String?) {
        self.data = data
        self.prev = self
        self.next = self
    }
    
}

struct LinkedList {
    let head = Node(data: nil)
    
    var isEmpty: Bool {
        head.next?.data == nil
    }
    
    var first: Node? {
        head.next
    }
    
    // splice 메서드의 시간 복잡도: O(1)
    // - a, b, x의 이전 및 다음 노드들에 대한 참조를 갱신하므로 상수 시간 소요
    func splice(a: Node, b: Node, x: Node) {  // cut [a..b] after x
        //        조건 1: a 노드 다음에 b 노드가 존재한다. (바로 옆이 아니어도 상관없음)
        //        조건 2: a 노드와 b 노드 사이에 head(더미) 노드가 존재하지 않는다.
        //        조건 3: a 노드와 b 노드 사이에 x 노드가 존재하지 않는다.
        
        // Check if a, b, and x are in the list
        guard let aPrev = a.prev, let bNext = b.next, let xNext = x.next else { return }
        
        // Disconnect [a..b]
        aPrev.next = bNext
        bNext.prev = aPrev
        
        // Connect [a..b] after x
        x.next = a
        a.prev = x
        b.next = xNext
        xNext.prev = b
    }
    
    func append(data: String) {
        guard let headPrev = head.prev else { return }
        
        let newNode = Node(data: data)
        self.splice(a: newNode, b: newNode, x: headPrev)
        
    }
    
    func insertAfter(data: String, at node: Node) {
        
        let newNode = Node(data: data)
        splice(a: newNode, b: newNode, x: node)
    }
    
    func remove(x: Node) -> Node? {
        guard let _ = x.data else { return nil }  // 헤드 노드 remove x
        
        x.next?.prev = x.prev
        x.prev?.next = x.next
        return x
    }
    
    func printList() {
            var current = head.next
            while let data = current?.data {
                print("\(data) -> ", terminator: "")
                current = current?.next
            }
            print("nil")
        }
        
}




//MARK: - solve 1
//let list = LinkedList()
//
//// 초기 값 리스트에 저장
//for a in n {
//    list.append(data: String(a))
//}
//
//// 커서
//var c = list.head.prev
//
//
//func textInput(input: String) {
//    
//    if input == "L" && c?.prev?.data != nil {
//        c = c?.prev
//    }
//    else if input == "D" && c?.next?.data != nil {
//        c = c?.next
//    }
//    else if input == "B" {
//        
//    }
//    else {
//        
//    }
//}

//MARK: - input
let n = readLine()!
var m = Int(readLine()!)!

//MARK: - solve 2 - Stack 두 개 이용

var left: [Character] = Array(n)
var right: [Character] = []

while m > 0 {
    
    let a = readLine()
    
    if a == "L" {
        
        if left.isEmpty {
            m -= 1
            continue
        }
        
        right.append(left.removeLast())
    }
    else if a == "D" {
        
        if right.isEmpty {
            m -= 1
            continue
        }

        left.append(right.removeLast())
    }
    else if a == "B" {
        
        if left.isEmpty {
            m -= 1
            continue
        }
        
        left.removeLast()
    }
    else {
        
        left.append(a!.last!)
    }
    
    m -= 1
}

let ans = left + right.reversed()


//MARK: - output

print(String(ans))



