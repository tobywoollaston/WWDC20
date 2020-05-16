import UIKit

public class PathFinding: UIView {
    
    private var map: Map!
    
    public init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 700, height: 700))
        self.backgroundColor = .lightGray
        
        map = Map()
        self.addSubview(map)
        
        let menus = MenuBar(self)
        menus.frame = CGRect(x: 0, y: 650, width: 700, height: 50)
        self.addSubview(menus)
    }
    
    public func resetMap() {
        map.clear()
    }
    
    public func findPath(_ algorithm: Algorithms) {
        map.clearPath()
        var visitedNodes = [Node]()
        var newGrid = [[Node]]()
        switch algorithm {
        case Algorithms.dijkstra:
            let algo = Dijkstra(map.getGrid(), map.getStart(), map.getEnd())
            visitedNodes = algo.getVisitedOrder()
            newGrid = algo.getGrid()
            break
        case Algorithms.astar:
            let algo = Astar(map.getGrid(), map.getStart(), map.getEnd())
            visitedNodes = algo.getVisitedOrder()
            newGrid = algo.getGrid()
            break
        }
        
        map.show(visitedNodes, newGrid)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

