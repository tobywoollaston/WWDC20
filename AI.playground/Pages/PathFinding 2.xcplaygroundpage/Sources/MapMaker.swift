import Foundation

class MapMaker {
    
    let width: Int
    let height: Int
    let size: Int
    
    var start: Node!
    var end: Node!
    
    init(_ width: Int, _ height: Int, _ size: Int) {
        self.width = width
        self.height = height
        self.size = size
    }

    func getBasicRandomMaze() -> [[Node]] {
        var grid = [[Node]]()
        for j in 0..<height/size {
            var row = [Node]()
            for i in 0..<width/size {
                row.append(Node(i, j))
                if Int.random(in: 1...4) == 1 {
                    row[i].type = .wall
                }
            }
            grid.append(row)
        }
        
        self.start = grid[Int.random(in: 0...(grid.count/4))][Int.random(in: 0...(grid[0].count/4))]
        self.start.type = .start
        self.end = grid[Int.random(in: (3*grid.count/4)...(grid.count))][Int.random(in: (3*grid[0].count/4)...(grid[0].count))]
        self.end.type = .end
        return grid
    }
    
    func getZigZagMaze() -> [[Node]] {
        var grid = [[Node]]()
        for j in 0..<height/size {
            var row = [Node]()
            for i in 0..<width/size {
                row.append(Node(i, j))
            }
            grid.append(row)
        }
        
        return grid
    }
    
    func getStart() -> Node {
        return start
    }
    
    func getEnd() -> Node {
        return end
    }
    
}

