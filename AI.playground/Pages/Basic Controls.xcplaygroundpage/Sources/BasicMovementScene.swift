import SpriteKit

class BasicMovementScene: SKScene {
    
    public override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        let background = SKSpriteNode(imageNamed: "perlin.png")
        background.scale(to: view.frame.size)
        background.position = CGPoint(x: frame.size.width/2, y: frame.size.height/2)
        addChild(background)

        setupRobot()
        
    }
    
    private func setupRobot() {
        
        let robot = BasicRobotSprite(imageNamed: "Mini-Robot-Standing-1.png")
        robot.position = CGPoint(x: frame.size.width/2, y: frame.size.height/2)
        
        addChild(robot)
        robot.setup()
        
    }
    
}
