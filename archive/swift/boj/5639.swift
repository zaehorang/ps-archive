//
// 5639.swift
// Swift_Algorithm
//
// Created by zaehorang on 2026/3/11.
// https://acmicpc.net/problem/5639
//

import Foundation

func _5639() {
    // Your solution here
    var tree: [Int] = .init(repeating: -1, count : 1000005)
    // 배열 인덱스로 완전이진트리처럼 저장하는 방식.
    // 하지만 입력이 1, 2, 3, 4처럼 크기 순으로 들어오면
    // 오른쪽 자식으로만 계속 내려가며 index가 1 -> 3 -> 7 -> 15처럼 커진다.
    // 즉, 실제 노드 수는 많지 않아도 필요한 배열 인덱스가 폭발해서 감당할 수 없다.
    let top = 1
    
    func append(_ n: Int) {
        var index = top
        
        while true {
            guard tree[index] != -1 else {
                tree[index] = n
                return
            }
            
            if tree[index] > n {
                index = index * 2
            } else {
                // n이 계속 증가하는 순서로 들어오면 오른쪽으로만 이동하게 되고,
                // index가 빠르게 커져 배열 기반 저장 방식으로는 감당이 어렵다.
                index = index * 2 + 1
            }
        }
    }
    
    while let line = readLine(), let n = Int(line) {
        append(n)
    }
    print(tree)
    
}

func _5639_() {
    final class Node {
        let value: Int
        var left: Node?
        var right: Node?
        
        init(_ value: Int) {
            self.value = value
        }
        
        func append(_ newValue: Int) {
            if newValue < value {
                if let left {
                    left.append(newValue)
                } else {
                    left = Node(newValue)
                }
            } else {
                if let right {
                    right.append(newValue)
                } else {
                    right = Node(newValue)
                }
            }
        }
    }
    
    var root: Node?
    
    
    while let line = readLine(), let n = Int(line) {
        if let root {
            root.append(n)
        } else {
            root = Node(n)
        }
    }
    
    var ans = String()
    
    func postorder(_ node: Node?) {
        guard let node else { return }
        postorder(node.left)
        postorder(node.right)
        ans += "\(node.value)\n"
    }
    
    postorder(root)
    print(ans)
    
}

/*
 전위 순회는 부모를 먼저 주고, BST는 자식이 들어갈 수 있는 범위를 정해준다.
 그래서 범위만 잘 관리하면, 트리를 안 만들어도 후위 순회를 만들 수 있다.
 */
func _5639_1() {
    var preorder: [Int] = []
    
    while let line = readLine(), let n = Int(line) {
        preorder.append(n)
    }
    
    var index = 0
    var result = ""
    
    func postorder(_ lower: Int, _ upper: Int) {
        if index >= preorder.count { return }
        
        let value = preorder[index]
        
        // 현재 값이 이 서브트리에 들어올 수 없는 값이면 종료
        if value <= lower || value >= upper { return }
        
        index += 1
        
        // 왼쪽 서브트리: value보다 작은 값들
        postorder(lower, value)
        
        // 오른쪽 서브트리: value보다 큰 값들
        postorder(value, upper)
        
        // 후위 순회이므로 마지막에 루트 출력
        result += "\(value)\n"
    }
    
    postorder(Int.min, Int.max)
    print(result)
}
