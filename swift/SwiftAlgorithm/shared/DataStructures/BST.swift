//
//  BST.swift
//  SwiftAlgorithm
//
//  Created by zaehorang on 6/9/26.
//

import Foundation

// Binary Search Tree
//
// 주요 연산의 시간복잡도는 트리의 높이 h에 비례한다.
// 균형 잡힌 트리라면 h = log n 이므로 평균 O(log n),
// 한쪽으로 치우친 트리라면 h = n 이므로 최악 O(n)이 된다.
//
// insert / contains / findMin / findMax / remove: O(h)
// - 평균: O(log n)
// - 최악: O(n)
//
// inorder / preorder / postorder: O(n)
// - 모든 노드를 한 번씩 방문하기 때문

final class TreeNode {
    var value: Int
    var left: TreeNode?
    var right: TreeNode?
    
    init(_ value: Int) {
        self.value = value
    }
}

final class BinarySearchTree {
    private(set) var root: TreeNode?
    
    // MARK: - Insert Recursive
    
    func insert(_ value: Int) {
        // 전체 트리의 root부터 삽입을 시작한다.
        // insert(root, value)의 반환값은 삽입 후 전체 트리의 새로운 root이다.
        root = insert(root, value)
    }
    
    private func insert(_ node: TreeNode?, _ value: Int) -> TreeNode {
        // nil을 만났다는 것은 삽입할 위치를 찾았다는 뜻이다.
        // 새 노드를 만들어 현재 서브트리의 root로 반환한다.
        guard let node else {
            return TreeNode(value)
        }
        
        if value < node.value {
            // 삽입 후 왼쪽 서브트리의 root를 다시 연결한다.
            node.left = insert(node.left, value)
        } else if value > node.value {
            // 삽입 후 오른쪽 서브트리의 root를 다시 연결한다.
            node.right = insert(node.right, value)
        } else {
            // 중복 값은 넣지 않는 정책
            return node
        }
        
        // 현재 node는 여전히 이 서브트리의 root이므로 반환한다.
        return node
    }
    
    // MARK: - Insert Iterative
    
    func insertIterative(_ value: Int) {
        // 트리가 비어 있으면 새 노드가 root가 된다.
        guard let root else {
            self.root = TreeNode(value)
            return
        }
        
        var current: TreeNode? = root
        
        while let node = current {
            if value < node.value {
                // 왼쪽이 비어 있으면 그 위치에 삽입한다.
                if node.left == nil {
                    node.left = TreeNode(value)
                    return
                }
                
                // 더 작으므로 왼쪽으로 이동한다.
                current = node.left
            } else if value > node.value {
                // 오른쪽이 비어 있으면 그 위치에 삽입한다.
                if node.right == nil {
                    node.right = TreeNode(value)
                    return
                }
                
                // 더 크므로 오른쪽으로 이동한다.
                current = node.right
            } else {
                // 중복 값은 넣지 않는 정책
                return
            }
        }
    }
    
    // MARK: - Search
    
    func contains(_ value: Int) -> Bool {
        var current = root
        
        while let node = current {
            if value == node.value {
                return true
            } else if value < node.value {
                // 찾는 값이 현재 값보다 작으면 왼쪽으로 이동
                current = node.left
            } else {
                // 찾는 값이 현재 값보다 크면 오른쪽으로 이동
                current = node.right
            }
        }
        
        // nil까지 도달했다는 것은 값이 없다는 뜻
        return false
    }
    
    // MARK: - Find Min
    
    func findMin() -> Int? {
        guard let root else { return nil }
        
        var current: TreeNode? = root
        
        // BST에서 가장 작은 값은 계속 왼쪽으로 간 끝에 있다.
        while let left = current?.left {
            current = left
        }
        
        return current?.value
    }
    
    // MARK: - Find Max
    
    func findMax() -> Int? {
        guard let root else { return nil }
        
        var current: TreeNode? = root
        
        // BST에서 가장 큰 값은 계속 오른쪽으로 간 끝에 있다.
        while let right = current?.right {
            current = right
        }
        
        return current?.value
    }
    
    // MARK: - Remove
    
    func remove(_ value: Int) {
        // remove(root, value)의 반환값은 삭제 후 전체 트리의 새로운 root이다.
        root = remove(root, value)
    }
    
    private func remove(_ node: TreeNode?, _ value: Int) -> TreeNode? {
        // nil을 만났다는 것은 삭제할 값이 없다는 뜻이다.
        guard let node else {
            return nil
        }
        
        if value < node.value {
            // 삭제 대상이 왼쪽 서브트리에 있다.
            // 삭제 후 왼쪽 서브트리의 새로운 root를 다시 연결한다.
            node.left = remove(node.left, value)
            return node
        }
        
        if value > node.value {
            // 삭제 대상이 오른쪽 서브트리에 있다.
            // 삭제 후 오른쪽 서브트리의 새로운 root를 다시 연결한다.
            node.right = remove(node.right, value)
            return node
        }
        
        // 여기까지 왔다는 것은 node.value == value
        // 즉, 삭제할 노드를 찾은 상태이다.
        
        // Case 1. 자식이 없는 경우
        // 이 노드를 삭제하면 현재 서브트리는 비게 된다.
        if node.left == nil && node.right == nil {
            return nil
        }
        
        // Case 2-1. 오른쪽 자식만 있는 경우
        // 현재 노드를 삭제하고 오른쪽 자식이 이 서브트리의 새로운 root가 된다.
        if node.left == nil {
            return node.right
        }
        
        // Case 2-2. 왼쪽 자식만 있는 경우
        // 현재 노드를 삭제하고 왼쪽 자식이 이 서브트리의 새로운 root가 된다.
        if node.right == nil {
            return node.left
        }
        
        // Case 3. 자식이 둘 다 있는 경우
        // 오른쪽 서브트리에서 가장 작은 값, 즉 successor를 찾는다.
        let successorValue = findMinValue(node.right)
        
        // 현재 노드의 값을 successor 값으로 교체한다.
        node.value = successorValue
        
        // 오른쪽 서브트리에 남아 있는 successor 원본 노드를 삭제한다.
        node.right = remove(node.right, successorValue)
        
        // 값만 바뀌었을 뿐 현재 node는 여전히 이 서브트리의 root이다.
        return node
    }
    
    private func findMinValue(_ node: TreeNode?) -> Int {
        var current = node
        
        // 현재 서브트리에서 가장 작은 값은 계속 왼쪽으로 간 끝에 있다.
        while let left = current?.left {
            current = left
        }
        
        return current!.value
    }
    
    // MARK: - Traversal
    
    // Inorder: Left - Middle - Right
    // BST에서 inorder 결과는 오름차순 정렬된 배열이 된다.
    func inorder() -> [Int] {
        var result: [Int] = []
        inorder(root, &result)
        return result
    }
    
    private func inorder(_ node: TreeNode?, _ result: inout [Int]) {
        guard let node else { return }
        
        inorder(node.left, &result)
        result.append(node.value)
        inorder(node.right, &result)
    }
    
    // Preorder: Middle - Left - Right
    func preorder() -> [Int] {
        var result: [Int] = []
        preorder(root, &result)
        return result
    }
    
    private func preorder(_ node: TreeNode?, _ result: inout [Int]) {
        guard let node else { return }
        
        result.append(node.value)
        preorder(node.left, &result)
        preorder(node.right, &result)
    }
    
    // Postorder: Left - Right - Middle
    func postorder() -> [Int] {
        var result: [Int] = []
        postorder(root, &result)
        return result
    }
    
    private func postorder(_ node: TreeNode?, _ result: inout [Int]) {
        guard let node else { return }
        
        postorder(node.left, &result)
        postorder(node.right, &result)
        result.append(node.value)
    }
}

extension BinarySearchTree {
    func isValidBST() -> Bool {
        isValidBST(root, lower: nil, upper: nil)
    }

    private func isValidBST(_ node: TreeNode?, lower: Int?, upper: Int?) -> Bool {
        guard let node else {
            return true
        }

        if let lower, node.value <= lower {
            return false
        }

        if let upper, node.value >= upper {
            return false
        }

        return isValidBST(node.left, lower: lower, upper: node.value)
            && isValidBST(node.right, lower: node.value, upper: upper)
    }
}
