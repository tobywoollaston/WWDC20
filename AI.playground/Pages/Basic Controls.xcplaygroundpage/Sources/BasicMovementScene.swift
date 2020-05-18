import SpriteKit

class BasicMovementScene: SKScene {
    
    private let robotActions: BasicRobot
    private var robot: BasicRobotSprite!
    
    public init(size: CGSize, robot: BasicRobot) {
        robotActions = robot
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        let background = SKSpriteNode(imageNamed: "perlin.png")
        background.scale(to: view.frame.size)
        background.position = CGPoint(x: frame.size.width/2, y: frame.size.height/2)
        addChild(background)

        setupRobot()
        
        setupCoins()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            self.runActions()
        })
        
    }
    
    private func setupRobot() {
        
        robot = BasicRobotSprite()
        robot.node().position = CGPoint(x: frame.size.width/2, y: frame.size.height/2)
        
        addChild(robot.node())
        
    }
    
    var coins: [SKSpriteNode] = [SKSpriteNode]()
    
    private func setupCoins() {
        
        let coin1 = SKSpriteNode(imageNamed: "coin.png")
        coin1.size = CGSize(width: 40, height: 40)
        coin1.position = CGPoint(x: frame.size.width/2 - 250, y: frame.size.height/2 + 250)
        addChild(coin1)
        coins.append(coin1)
        
        let coin2 = SKSpriteNode(imageNamed: "coin.png")
        coin2.size = CGSize(width: 40, height: 40)
        coin2.position = CGPoint(x: frame.size.width/2 + 200, y: frame.size.height/2)
        addChild(coin2)
        coins.append(coin2)
        
        let coin3 = SKSpriteNode(imageNamed: "coin.png")
        coin3.size = CGSize(width: 40, height: 40)
        coin3.position = CGPoint(x: frame.size.width/2 - 150, y: frame.size.height/2 - 300)
        addChild(coin3)
        coins.append(coin3)
        
    }
    
    private func runActions() {
        for action in robotActions.getActions() {
            switch action {
            case BasicRobot.Actions.forward:
                robot.moveForward()
                break
            case BasicRobot.Actions.backward:
                robot.moveBackward()
                break
            case BasicRobot.Actions.rotateLeft:
                robot.rotateLeft()
                break
            case BasicRobot.Actions.rotateRight:
                robot.rotateRight()
                break
            }
        }
        robot.run()
    }
    
    public override func didFinishUpdate() {
        super.didFinishUpdate()
        
        for coin in coins {
            if Int(robot.node().position.x) == Int(coin.position.x) && Int(robot.node().position.y) == Int(coin.position.y) {
                coin.removeFromParent()
                coin.position = CGPoint(x: 100000, y: 100000)
            }
        }
    }
    
}
