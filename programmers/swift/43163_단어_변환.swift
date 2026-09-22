import Foundation

func solution(_ begin:String, _ target:String, _ words:[String]) -> Int {
        var isUsed = [Bool](repeating: false, count: words.count)
    var ans = 51
    
    func canChange(_ a: String, _ b: String) -> Bool {
        var cnt = 0
        for i in 0..<a.count {
            if a[a.index(a.startIndex, offsetBy: i)] != b[b.index(b.startIndex, offsetBy: i)] {
                cnt += 1
            }
        }
        return cnt == 1 ? true : false
    }
    
    func recursion(n: Int, str: String) {
        if str == target {
            ans = min(ans, n)
            return
        }
        
        for i in 0..<words.count {
            if !isUsed[i] && canChange(str, words[i]) {
                isUsed[i] = true
                recursion(n: n + 1, str: words[i])
                isUsed[i] = false
            }
        }
    }
    
    recursion(n: 0, str: begin)
    
    return ans == 51 ? 0 : ans
}