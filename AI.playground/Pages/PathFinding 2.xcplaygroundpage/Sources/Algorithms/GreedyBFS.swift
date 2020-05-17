import Foundation

class GreedyBFS {
    
    private var openSet: [Node]
    private let grid: [[Node]]
    private let start: Node
    private let end: Node
    
    private var visitedOrder: [Node]
    
    init(_ grid: [[Node]], _ start: Node, _ end: Node) {
        self.openSet = [Node]()
        self.grid = grid
        self.start = start
        self.end = end
        self.visitedOrder = [Node]()
        
        run()
    }
    
    private func run() {
        var heuristic = [[Int]]()
        for j in 0..<grid.count {
            var row = [Int]()
            for i in 0..<grid[j].count {
                if grid[j][i].type == .wall {
                    row.append(Int.max)
                } else {
                    let h = abs(i - end.i) + abs(j - end.j)
                    //                    let h = powf(powf(Float(abs(i - end.i)), 2) + powf(Float(abs(j - end.j)), 2), 0.5)
                    row.append(h)
                }
            }
            heuristic.append(row)
        }
        
        start.heuristic = heuristic[start.j][start.i]
        openSet.append(start)
        
        while openSet.count > 0 {
            openSet.sort { (a, b) -> Bool in
                return a.heuristic < b.heuristic
            }
            
            let current = openSet.removeFirst()
            if current.i == end.i && current.j == end.j {
                openSet.removeAll()
                continue
            }
            
            current.visited = true
            visitedOrder.append(current)
            
            addNeighbour(current.i + 1, current.j, heuristic: heuristic, prevNode: current)
            addNeighbour(current.i - 1, current.j, heuristic: heuristic, prevNode: current)
            addNeighbour(current.i, current.j + 1, heuristic: heuristic, prevNode: current)
            addNeighbour(current.i, current.j - 1, heuristic: heuristic, prevNode: current)
            
        }
    }
    
    private func addNeighbour(_ i: Int, _ j: Int, heuristic: [[Int]], prevNode: Node) {
        if i < grid[0].count && i >= 0 && j < grid.count && j >= 0 {
            let n = grid[j][i]
            if n.visited == false && n.previousNode == nil && n.type != NodeType.wall {
                n.heuristic = heuristic[n.j][n.i]
                n.previousNode = prevNode
                openSet.append(n)
            }
        }
    }
    
    public func getVisitedOrder() -> [Node] {
        return self.visitedOrder
    }
    
    public func getGrid() -> [[Node]] {
        return self.grid
    }
    
}
