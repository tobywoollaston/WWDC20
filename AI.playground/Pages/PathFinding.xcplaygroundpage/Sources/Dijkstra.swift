import Foundation

public class Dijkstra {
    
    private var openSet: [Node]
    private let grid: [[Node]]
    private let start: Node
    private let end: Node
    
    public init(_ grid: [[Node]], _ start: Node, _ end: Node) {
        self.openSet = [start]
        self.grid = grid
        self.start = start
        self.end = end
    }
    
    public func calc() {
        print(openSet.count)
        if openSet.count > 0 {
            openSet.sort { (a, b) -> Bool in
                return a.prevDistance < b.prevDistance
            }
            
            let current = openSet.removeFirst()
            if current.i == end.i && current.j == end.j {
                openSet.removeAll()
                return
            }
            
            current.distance = current.prevDistance + 1
            current.visited = true
            
            addNeighbour(current.i + 1, current.j, prevDistance: current.distance)
            addNeighbour(current.i - 1, current.j, prevDistance: current.distance)
            addNeighbour(current.i, current.j + 1, prevDistance: current.distance)
            addNeighbour(current.i, current.j - 1, prevDistance: current.distance)
            
        }
    }
    
    private func addNeighbour(_ i: Int, _ j: Int, prevDistance: Int) {
        if i < grid[0].count && i >= 0 && j < grid.count && j >= 0 {
            let n = grid[j][i]
            if n.visited == false && n.added == false {
                n.prevDistance = prevDistance
                openSet.append(n)
                n.added = true
            }
        }
    }
    
}
