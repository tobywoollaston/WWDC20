import SpriteKit

class BasicRobotSprite {
    
    private let robotSprite: SKSpriteNode
    
    public init() {
        robotSprite = SKSpriteNode(imageNamed: "Mini-Robot-Standing-1.png")
        robotSprite.size = CGSize(width: 125, height: 125)
        robotSprite.color = .blue
        stand()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func stand() {
        var standing = [SKTexture]()
        for i in 1...3 {
            standing.append(SKTexture(imageNamed: "Mini-Robot-Standing-\(i).png"))
        }
        standing.append(standing[1])
        for _ in 1...25 {
            standing.append(standing[0])
        }
        let standingAni = SKAction.animate(with: standing, timePerFrame: 0.1)
        robotSprite.run(SKAction.repeatForever(standingAni))
    }
    
    private func walk() {
        var moving = [SKTexture]()
        for i in 1...3 {
            moving.append(SKTexture(imageNamed: "Mini-Robot-Walking-\(i).png"))
        }
        moving.append(moving[1])
        
        let movingAni = SKAction.animate(with: moving, timePerFrame: 0.1)
        robotSprite.run(SKAction.repeatForever(movingAni))
    }
    
    public func node() -> SKSpriteNode {
        return robotSprite
    }
    
    var actions = [SKAction]()
    var state = 0
    var movement = CGPoint(x: 0, y: 50)
    
    public func moveForward() {
        let move = SKAction.sequence([SKAction.run({self.walk()}), SKAction.moveBy(x: movement.x, y: movement.y, duration: 2), SKAction.run({self.stand()}), SKAction.wait(forDuration: 1.25)])
        actions.append(move)
    }
    
    public func moveBackward() {
        let move = SKAction.sequence([SKAction.run({self.walk()}), SKAction.moveBy(x: -movement.x, y: -movement.y, duration: 2), SKAction.run({self.stand()}), SKAction.wait(forDuration: 1.25)])
        actions.append(move)
    }
    
    public func rotateRight() {
        state = (state + 1) % 4
        stateUpdate()
    }
    
    public func rotateLeft() {
        state = (state-1 == -1 ? 3 : state-1) % 4
        stateUpdate()
    }
    
    private func stateUpdate() {
        if state % 4 == 0 {
            movement = CGPoint(x: 0, y: 50)
        } else if state % 4 == 1 {
            movement = CGPoint(x: 50, y: 0)
        } else if state % 4 == 2 {
            movement = CGPoint(x: 0, y: -50)
        } else if state % 4 == 3 {
            movement = CGPoint(x: -50, y: 0)
        }
    }
    
    public func run() {
        robotSprite.run(SKAction.sequence(actions))
    }
    
}
