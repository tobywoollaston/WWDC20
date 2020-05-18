import UIKit
import SpriteKit

public class BasicControls: UIView {
    
    public init(_ robot: BasicRobot) {
        super.init(frame: CGRect(x: 0, y: 0, width: 700, height: 700))
        self.backgroundColor = .red
        
        setup(robot)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup(_ robot: BasicRobot) {
        let gameView = SKView(frame: self.frame)
        gameView.showsFPS = true
        gameView.showsNodeCount = true
        addSubview(gameView)
        
        let scene = BasicMovementScene(size: self.bounds.size, robot: robot)
        scene.scaleMode = .resizeFill
        gameView.presentScene(scene)
    }
    
}
