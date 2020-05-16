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
        if openSet.count > 0 {
//            openSet.sort { (a, b) -> Bool in
//                return a.distance < b.distance
//            }
            
            let current = openSet.removeFirst()
            if current.i == end.i && current.j == end.j {
                print("done")
                return
            }
            
            current.distance = current.prevDistance + 1
            current.visited = true
            
            if current.i < grid[current.j].count - 1 {
                let n = grid[current.j][current.i + 1]
                if n.visited == false {
                    n.prevDistance = current.distance
                    openSet.append(n)
                }
            }
            if current.i > 0 {
                let n = grid[current.j][current.i - 1]
                if n.visited == false {
                    n.prevDistance = current.distance
                    openSet.append(n)
                }
            }
            if current.j < grid.count - 1 {
                let n = grid[current.j + 1][current.i]
                if n.visited == false {
                    n.prevDistance = current.distance
                    openSet.append(n)
                }
            }
            if current.j > 0 {
                let n = grid[current.j - 1][current.i]
                if n.visited == false {
                    n.prevDistance = current.distance
                    openSet.append(n)
                }
            }
            
        }
    }
    
}
