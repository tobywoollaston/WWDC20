import UIKit

public class PathFindingView: UIView {
    
    private let size = 700
    private let length = 20
    private var grid = [[Node]]()
    
    private var pathFind: Dijkstra? = nil
    
    public init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 700, height: 700))
        self.backgroundColor = .white
        
        for j in 0..<size/length {
            var row = [Node]()
            for i in 0..<size/length {
                row.append(Node(i, j))
            }
            grid.append(row)
        }
        
        let startN = grid[(size/length)-4][4]
        startN.type = .start
        let endN = grid[4][(size/length)-4]
        endN.type = .end
        
        self.pathFind = Dijkstra(grid, startN, endN)
        Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(start), userInfo: nil, repeats: false)
    }
    
    @objc func start() {
        Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(update), userInfo: nil, repeats: true)
    }
    
    @objc func update() {
        pathFind!.calc()
        self.setNeedsDisplay()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
                        let stringToDraw = "\(value.distance)" as NSString // Replace with your string.
                        let rectToDraw = CGRect(x: i * length + 2, y: j * length + 2, width: length - 4, height: length - 4) // Replace with some CGRect.
                        stringToDraw.draw(in: rectToDraw, withAttributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
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
        for x in 1..<(size/length) {
            let line = UIBezierPath()
            line.move(to: CGPoint(x: 0, y: x * length))
            line.addLine(to: CGPoint(x: size, y: x * length))
            line.stroke()
        }
        for y in 1..<(size/length) {
            let line = UIBezierPath()
            line.move(to: CGPoint(x: y * length, y: 0))
            line.addLine(to: CGPoint(x: y * length, y: size))
            line.stroke()
        }
        
    }
    
    private func drawRect(i: Int, j: Int, col: UIColor) {
        let rect = UIBezierPath(rect: CGRect(x: i * length, y: j * length, width: length, height: length))
        col.setFill()
        rect.fill()
    }

    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        addPoint(touches)
    }

    override public func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        addPoint(touches)
    }

    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        addPoint(touches)
    }
    
    private func addPoint(_ touches: Set<UITouch>) {
        if let touch = touches.first {
            let currentPoint = touch.location(in: self)
            
            let width = CGFloat(size / (size/length))
            let i = Int(currentPoint.x / width)
            let j = Int(currentPoint.y / width)
            
            grid[j][i].type = .wall
            
            self.setNeedsDisplay()
        }
    }
    
}

