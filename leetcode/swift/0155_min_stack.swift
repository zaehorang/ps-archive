class MinStack {
    private var arr = [(Int, Int)]()
    private var minInt = Int.max

    init() {}

    func push(_ value: Int) {
        minInt = min(minInt, value)
        arr.append((value, minInt))
    }

    

    func pop() {
        if arr.isEmpty { return }
        arr.popLast()
        minInt = arr.last?.1 ?? Int.max
    }

    func top() -> Int {
        arr.last!.0
    }

    func getMin() -> Int {
        arr.last!.1
    }

}