import Foundation

public enum NodeType {
    case none
    case wall
    case start
    case end
}

public class Node {
    public let i: Int
    public let j: Int
    public var visited: Bool
    public var distance: Int
    public var type: NodeType
    public var prevDistance: Int
    public init(_ i: Int, _ j: Int) {
        self.i = i
        self.j = j
        self.visited = false
        self.type = .none
        self.distance = Int.max
        self.prevDistance = -1
    }
    public var description: String { return "Node: (\(i),\(j)) = d:\(distance)" }
}
