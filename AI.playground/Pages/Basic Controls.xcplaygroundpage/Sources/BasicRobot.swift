import Foundation

public class BasicRobot {
    
    public enum Actions {
        case forward
        case backward
        case rotateLeft
        case rotateRight
    }
    
    private var actions: [Actions] = [Actions]()
    
    public init() {
        
    }
    
    public func addAction(_ action: Actions) {
        actions.append(action)
    }
    
}
