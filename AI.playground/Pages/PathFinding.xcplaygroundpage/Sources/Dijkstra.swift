import Foundation

public class Dijkstra {
    
    private var openSet: [Node]
    private let grid: [[Node]]
    private let start: Node
    private let end: Node
    
    private var foundEnd: Bool
    private var current: Node?
    
    public init(_ grid: [[Node]], _ start: Node, _ end: Node) {
        start.distance = 0
        self.openSet = [start]
        self.grid = grid
        self.start = start
        self.end = end
        self.foundEnd = false
    }
    
    public func calc() {
        print(openSet.count)
        if openSet.count > 0 {
            openSet.sort { (a, b) -> Bool in
                return a.distance < b.distance
            }
            
            current = openSet.removeFirst()
            if current!.i == end.i && current!.j == end.j {
                openSet.removeAll()
                foundEnd = true
                current = end.previousNode
                return
            }
            
            current!.visited = true
            
            addNeighbour(current!.i + 1, current!.j, prevNode: current!)
            addNeighbour(current!.i - 1, current!.j, prevNode: current!)
            addNeighbour(current!.i, current!.j + 1, prevNode: current!)
            addNeighbour(current!.i, current!.j - 1, prevNode: current!)
            
        } else {
            if (foundEnd) {
                if current != nil {
                    current!.type = current!.type != NodeType.start ? NodeType.chosen : NodeType.start
                    current = current!.previousNode
                }
            } else {
                print("path not possible")
            }
        }
    }
    
    private func addNeighbour(_ i: Int, _ j: Int, prevNode: Node) {
        if i < grid[0].count && i >= 0 && j < grid.count && j >= 0 {
            let n = grid[j][i]
            if n.visited == false && n.previousNode == nil && n.type != NodeType.wall {
                n.distance = prevNode.distance + 1
                n.previousNode = prevNode
                openSet.append(n)
            }
        }
    }
    
}
