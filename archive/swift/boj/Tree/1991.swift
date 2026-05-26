//
//  1991.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 10/29/25.
//

import Foundation

func _1991_first() {
    let n = Int(readLine()!)!
    
    // make tree
    var tree: [String: [String]] = .init()
    
    for _ in 0..<n {
        let abc = readLine()!.split(separator: " ").map { String($0) }
        
        tree[abc[0]] = [abc[1], abc[2]]
    }
    
    func preorder() {
        var ans = ""
        
        func recursion(_ curr: String) {
            ans += curr
            guard let childs = tree[curr] else { return }
            
            if childs[0] != "." {
                recursion(childs[0])
            }
            
            if childs[1] != "." {
                recursion(childs[1])
            }
        }
        
        recursion("A")
        
        print(ans)
    }
    
    func inorder() {
        var ans = ""
        
        func recursion(_ curr: String) {
            guard let childs = tree[curr] else {
                ans += curr
                return
            }
            
            if childs[0] != "." {
                recursion(childs[0])
            }
            
            ans += curr
            
            if childs[1] != "." {
                recursion(childs[1])
            }
        }
        
        recursion("A")
        
        print(ans)
    }
    
    func postorder() {
        var ans = ""
        
        func recursion(_ curr: String) {
            guard let childs = tree[curr] else {
                ans += curr
                return
            }
            
            if childs[0] != "." {
                recursion(childs[0])
            }
            
            if childs[1] != "." {
                recursion(childs[1])
            }
            
            ans += curr
        }
        
        recursion("A")
        print(ans)
    }
    
    
    preorder()
    inorder()
    postorder()
}

func _1991_second() {
    let n = Int(readLine()!)!
    
    // make tree
    var tree: [String: [String]] = .init()
    
    for _ in 0..<n {
        let abc = readLine()!.split(separator: " ").map { String($0) }
        
        tree[abc[0]] = [abc[1], abc[2]]
    }
    
    func preorder() {
        var ans = ""
        
        func recursion(_ curr: String) {
            guard curr != "." else { return }
            ans += curr

            guard let childs = tree[curr] else { return }
            recursion(childs[0])
            recursion(childs[1])
        }
        
        recursion("A")
        
        print(ans)
    }
    
    func inorder() {
        var ans = ""
        
        func recursion(_ curr: String) {
            guard curr != "." else { return }
            
            guard let childs = tree[curr] else { return }
            recursion(childs[0])
            ans += curr
            recursion(childs[1])
        }
        
        recursion("A")
        
        print(ans)
    }
    
    func postorder() {
        var ans = ""
        
        func recursion(_ curr: String) {
            guard curr != "." else { return }
            
            guard let childs = tree[curr] else { return }
            recursion(childs[0])
            recursion(childs[1])
            ans += curr
        }
        
        recursion("A")
        print(ans)
    }
    
    
    preorder()
    inorder()
    postorder()
}
