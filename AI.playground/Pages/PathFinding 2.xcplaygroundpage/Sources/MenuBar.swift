import UIKit

public enum Algorithms: Int {
    case dijkstra
    case astar
    case greedyBFS
    static let count: Int = {
        var max: Int = 0
        while let _ = Algorithms(rawValue: max) { max += 1 }
        return max
    }()
}

class MenuBar: UIView {
    
    private let app: PathFinding
    
    var algoType: Algorithms = .dijkstra
    var algoPicker: UIButton!
    
    var statusLabel: UILabel!
    
    public init(_ app: PathFinding) {
        self.app = app
        super.init(frame: .zero)
        self.backgroundColor = .white
        
        let clearButton: UIButton = {
            let b = UIButton(type: .system)
            b.frame = CGRect(x: 585, y: 10, width: 110, height: 30)
            b.setTitle("Clear Board", for: .normal)
            b.titleLabel!.font = UIFont.systemFont(ofSize: 14)
            b.backgroundColor = UIColor(white: 0.9, alpha: 1)
            b.clipsToBounds = true
            b.layer.cornerRadius = 15
            b.addTarget(self, action: #selector(clearButtonTapped), for: .touchUpInside)
            return b
        }()
        self.addSubview(clearButton)
        
        let visualiseButton: UIButton = {
            let b = UIButton(type: .system)
            b.frame = CGRect(x: 385, y: 10, width: 190, height: 30)
            b.setTitle("Visualise Path Finding", for: .normal)
            b.titleLabel!.font = UIFont.systemFont(ofSize: 14)
            b.backgroundColor = UIColor(white: 0.9, alpha: 1)
            b.clipsToBounds = true
            b.layer.cornerRadius = 15
            b.addTarget(self, action: #selector(visualiseButtonTapped), for: .touchUpInside)
            return b
        }()
        self.addSubview(visualiseButton)
        
        algoPicker = {
            let b = UIButton(type: .system)
            b.frame = CGRect(x: 185, y: 10, width: 190, height: 30)
            b.setTitle("Dijkstra's Algorithm", for: .normal)
            b.titleLabel!.font = UIFont.systemFont(ofSize: 14)
            b.addTarget(nil, action: #selector(changeAlgo), for: .touchUpInside)
            b.backgroundColor = UIColor(white: 0.9, alpha: 1)
            b.clipsToBounds = true
            b.layer.cornerRadius = 15
            return b
        }()
        self.addSubview(algoPicker)
        
        statusLabel = {
            let l = UILabel()
            l.frame = CGRect(x: 5, y: 0, width: 180, height: 50)
            l.text = "Status: Incomplete"
            l.font = UIFont.systemFont(ofSize: 14)
            return l
        }()
        self.addSubview(statusLabel)
        
    }
    
    @objc func clearButtonTapped() {
        app.resetMap()
    }
    
    @objc func visualiseButtonTapped() {
        app.findPath(algoType)
    }
    
    @objc func changeAlgo() {
        algoType = Algorithms(rawValue: algoType.rawValue == Algorithms.count - 1 ? 0 : algoType.rawValue + 1)!
        switch algoType {
        case Algorithms.dijkstra:
            algoPicker.setTitle("Dijkstra's Algorithm", for: .normal)
            break
        case Algorithms.astar:
            algoPicker.setTitle("A* Search", for: .normal)
            break
        case Algorithms.greedyBFS:
            algoPicker.setTitle("Greedy Best First Search", for: .normal)
            break
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

