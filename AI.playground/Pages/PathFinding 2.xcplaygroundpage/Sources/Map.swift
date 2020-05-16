import UIKit

class Map: UIView {
    
    private let width = 700
    private let height = 650
    private let size = 25
    
    private var grid = [[Node]]()
    private var start: Node!
    private var end: Node!
    
    private var findingPath: Bool = false
    
    public init() {
        super.init(frame: CGRect(x: 0, y: 0, width: width, height: height))
        self.backgroundColor = .white
        
        clear()
        
    }
    
    public func getGrid() -> [[Node]] {
        var gridCopy = [[Node]]()
        for j in 0..<height/size {
            var row = [Node]()
            for i in 0..<width/size {
                row.append(grid[j][i].copy())
            }
            gridCopy.append(row)
        }
        return gridCopy
    }
    
    public func getStart() -> Node {
        return self.start.copy()
    }
    
    public func getEnd() -> Node {
        return self.end.copy()
    }
    
    override public func draw(_ rect: CGRect) {
        super.draw(rect)
        
        for j in 0..<grid.count {
            for i in 0..<grid[j].count {
                let value = self.grid[j][i]
                switch value.type {
                case NodeType.none:
                    if value.visited {
                        drawRect(i: i, j: j, col: UIColor(red: 89/255, green: 18/255, blue: 48/255, alpha: 1))
                    }
                    break
                case NodeType.wall:
                    drawRect(i: i, j: j, col: UIColor(red: 14/255, green: 167/255, blue: 255/255, alpha: 1))
                    break
                case NodeType.start:
                    drawRect(i: i, j: j, col: UIColor.green)
                    break
                case NodeType.end:
                    drawRect(i: i, j: j, col: UIColor.red)
                    break
                case NodeType.chosen:
                    drawRect(i: i, j: j, col: UIColor.yellow)
                    break
                }
            }
        }
        
        //grid lines
        UIColor.black.setStroke()
        for x in 1..<(width/size) {
            let line = UIBezierPath()
            line.move(to: CGPoint(x: x * size, y: 0))
            line.addLine(to: CGPoint(x: x * size, y: height))
            line.stroke()
        }
        for y in 1...(height/size) {
            let line = UIBezierPath()
            line.move(to: CGPoint(x: 0, y: y * size))
            line.addLine(to: CGPoint(x: width, y: y * size))
            line.stroke()
        }
        
    }
    
    private func drawRect(i: Int, j: Int, col: UIColor) {
        let rect = UIBezierPath(rect: CGRect(x: i * size, y: j * size, width: size, height: size))
        col.setFill()
        rect.fill()
    }
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        touched(touches)
    }

    override public func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        touched(touches)
    }

    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        touched(touches)
        movingStart = false
        movingEnd = false
    }
    
    private var movingStart: Bool = false
    private var movingEnd: Bool = false
    
    private func touched(_ touches: Set<UITouch>) {
        if !findingPath {
            clearPath()
            if let touch = touches.first {
                let currentPoint = touch.location(in: self)
                
                let width = CGFloat(self.width / (self.width/self.size))
                let height = CGFloat(self.height / (self.height/self.size))
                let i = Int(currentPoint.x / width)
                let j = Int(currentPoint.y / height)
                
                if i >= grid[0].count || i < 0 || j >= grid.count || j < 0 {
                    return
                }
                
                if ((i == start.i && j == start.j) || movingStart) && (i != end.i && j != end.j) {
                    movingStart = true
                    moveStart(i, j)
                } else if ((i == end.i && j == end.j) || movingEnd) && (i != start.i && j != start.j) {
                    movingEnd = true
                    moveEnd(i, j)
                } else {
                    addWall(i, j)
                    movingStart = false
                    movingEnd = false
                }
                
                self.setNeedsDisplay()
            }
        }
    }
    
    private func moveStart(_ i: Int, _ j: Int) {
        start.type = .none
        start = grid[j][i]
        start.type = .start
    }
    
    private func moveEnd(_ i: Int, _ j: Int) {
        end.type = .none
        end = grid[j][i]
        end.type = .end
    }
    
    private func addWall(_ i: Int, _ j: Int) {
        grid[j][i].type = .wall//grid[j][i].type == .wall ? .none : .wall
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func show(_ order: [Node], _ newGrid: [[Node]]) {
        findingPath = true
        var order = order
        if order.count > 0 {
            let next = order.removeFirst()
            grid[next.j][next.i].visited = true
            self.setNeedsDisplay()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.01, execute: {
                self.show(order, newGrid)
            })
        } else {
            grid = newGrid
            start = newGrid[start.j][start.i]
            end = newGrid[end.j][end.i]
            self.setNeedsDisplay()
            showPath(end.previousNode!)
        }
    }
    
    public func clearPath() {
        if start.visited == true {
            grid = getGrid()
        }
        self.setNeedsDisplay()
    }
    
    private func showPath(_ currentNode: Node) {
        currentNode.type = currentNode.type != NodeType.start ? NodeType.chosen : NodeType.start
        let currentNode = currentNode.previousNode
        self.setNeedsDisplay()
        if currentNode != nil {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.05, execute: {
                self.showPath(currentNode!)
            })
        } else {
            findingPath = false
        }
    }
    
    public func clear() {
        if !findingPath {
            grid.removeAll()
            for j in 0..<height/size {
                var row = [Node]()
                for i in 0..<width/size {
                    row.append(Node(i, j))
                }
                grid.append(row)
            }
            
            self.start = grid[4][4]
            self.start.type = .start
            self.end = grid[grid.count-4][grid[0].count-4]
            self.end.type = .end
            
            self.setNeedsDisplay()
        }
    }
    
}

