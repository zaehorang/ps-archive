//
//  15683.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 7/8/24.
//  https://www.acmicpc.net/problem/15683
//  감시

func _15683() {
    let nm = readLine()!.split(separator: " ").map { Int($0)! }
    let (n, m) = (nm[0], nm[1])
    
    var table1: [[Int]] = []
    var table2: [[Int]] = []  // 카메라 사각지대를 표시하기 위함
    
    var cameras: [(Int, Int)] = []  // 카메라 좌표 기록
    
    // 남, 서, 북, 동
    let dx = [1, 0, -1, 0]
    let dy = [0, -1, 0, 1]
    
    var ans = 0
    
    // input
    for _ in 0..<n {
        let a = readLine()!.split(separator: " ").map { Int($0)! }
        table1.append(a)
    }
    
    // 카메라 위치 찾기
    for x in 0..<n {
        for y in 0..<m {
            if table1[x][y] != 0 && table1[x][y] != 6 {
                cameras.append((x, y))
            } else if table1[x][y] == 0 {
                ans += 1  // 카메라가 없는 경우를 대비
            }
        }
    }
    
    // Out of Bounds 확인
    func oob(x: Int, y: Int) -> Bool {
        x < 0 || y < 0 || x >= n || y >= m
    }
    
    func upd(x: Int, y: Int, dir: Int) {  // 해당 방향으로 나아가기
        let newDir = dir % 4
        var (newX, newY) = (x, y)
        
        while true {
            newX += dx[newDir]
            newY += dy[newDir]
            
            if oob(x: newX, y: newY) || table1[newX][newY] == 6 { return }
            if table1[newX][newY] != 0 { continue }
            table2[newX][newY] = 7 // 방문 표시
        }
    }

    // 카메라가 향할 수 있는 모든 방향을 보기 위해
    // 카메라 수 ^ 4의 경우(카메라의 모든 경우의 수)를 보는 것
    for tmp in 0..<(1 << (2 * cameras.count)) {
        table2 = table1  // table2 리셋
        var brute = tmp
        
        for (x, y) in cameras {
            let dir = brute % 4  // 방향 정하기
            brute /= 4
            
            if table1[x][y] == 1 {
                upd(x: x, y: y, dir: dir)
            } else if table1[x][y] == 2 {
                upd(x: x, y: y, dir: dir)
                upd(x: x, y: y, dir: dir + 2)
            } else if table1[x][y] == 3 {
                upd(x: x, y: y, dir: dir)
                upd(x: x, y: y, dir: dir + 1)
            } else if table1[x][y] == 4 {
                upd(x: x, y: y, dir: dir)
                upd(x: x, y: y, dir: dir + 1)
                upd(x: x, y: y, dir: dir + 2)
            } else { // 5
                upd(x: x, y: y, dir: dir)
                upd(x: x, y: y, dir: dir + 1)
                upd(x: x, y: y, dir: dir + 2)
                upd(x: x, y: y, dir: dir + 3)
            }
        }
        
        var cnt = 0
        for arr in table2 {
            for n in arr {
                if n == 0 { cnt += 1 }
            }
        }
        
        ans = min(ans, cnt)
        
    }
    print(ans)
}

func _other() {
    // Input
    let nm = readLine()!.split(separator: " ").map { Int($0)! }
    let (n, m) = (nm[0], nm[1])
    
    var table1: [[Int]] = []
    var table2: [[Int]] = []
    
    for _ in 0..<n {
        let a = readLine()!.split(separator: " ").map { Int($0)! }
        table1.append(a)
    }

    // 카메라 위치 찾기
    var cameras: [(Int, Int)] = []
    var ans = 0
    
    for x in 0..<n {
        for y in 0..<m {
            if table1[x][y] != 0 && table1[x][y] != 6 {
                cameras.append((x, y))
            } else if table1[x][y] == 0 {
                ans += 1  // 카메라가 없는 경우를 대비
            }
        }
    }
    
    // table 범위 확인: Out of bounds
    func oob(x: Int, y: Int) -> Bool {
        x < 0 || y < 0 || x >= n || y >= m
    }
    
    let dx = [1, 0, -1, 0]
    let dy = [0, -1, 0, 1]
    
    // 카메라의 방향이 정해지면 끝까지 표시하는 메서드
    func upd(x: Int, y: Int, dir: Int) {
        
        let newDir = dir % 4  // ❗️아래에서 방향 잡을 때 dir이 4를 넘을 수 있으니까
        var (newX, newY) = (x, y)  // ❗️계속 증가해야 하니까 반복문 외부에 선언
        
        while true {
            newX += dx[newDir]
            newY += dy[newDir]
            
            if oob(x: newX, y: newY) || table1[newX][newY] == 6 { return }
            if table1[newX][newY] != 0 { continue }
            table2[newX][newY] = 7 // 방문 표시
        }
        
    }
    
    
    let allCnt = 1 << (2 * cameras.count)
    
    for i in 0..<allCnt {
        table2 = table1
        
        var num = i
        
        for (x, y) in cameras {
            let dir = num % 4
            num /= 4
            
            if table2[x][y] == 1 {
                upd(x: x, y: y, dir: dir)
            } else if table2[x][y] == 2 {
                upd(x: x, y: y, dir: dir)
                upd(x: x, y: y, dir: dir + 2)
            } else if table2[x][y] == 3 {
                upd(x: x, y: y, dir: dir)
                upd(x: x, y: y, dir: dir + 1)
            } else if table2[x][y] == 4 {
                upd(x: x, y: y, dir: dir)
                upd(x: x, y: y, dir: dir + 1)
                upd(x: x, y: y, dir: dir + 2)
            } else {
                upd(x: x, y: y, dir: dir)
                upd(x: x, y: y, dir: dir + 1)
                upd(x: x, y: y, dir: dir + 2)
                upd(x: x, y: y, dir: dir + 3)
            }
        }
        
        // 카운팅
        var cnt = 0
        
        for arr in table2 {
            for n in arr {
                if n == 0 {
                    cnt += 1
                }
            }
        }
        
        ans = min(cnt, ans)
    }
    
    print(ans)
}
