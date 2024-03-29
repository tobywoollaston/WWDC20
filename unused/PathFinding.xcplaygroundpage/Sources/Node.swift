import Foundation

public enum NodeType {
    case none
    case wall
    case start
    case end
    case chosen
}

public class Node {
    public let i: Int
    public let j: Int
    public var visited: Bool
    public var distance: Int
    public var type: NodeType
    public var previousNode: Node?
    public var added: Bool
    public init(_ i: Int, _ j: Int) {
        self.i = i
        self.j = j
        self.visited = false
        self.type = .none
        self.distance = Int.max
        self.added = false
    }
    public var description: String { return "Node: (\(i),\(j)) = d:\(distance)" }
}
