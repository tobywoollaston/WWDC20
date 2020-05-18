import SpriteKit

class BasicRobotSprite: SKSpriteNode {
    
    public convenience init(imageNamed: String) {
        self.init(imageNamed: imageNamed)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setup() {
        var standing = [SKTexture]()
        for i in 1...3 {
            standing.append(SKTexture(imageNamed: "Mini-Robot-Standing-\(i).png"))
        }
        standing.append(standing[1])
        for _ in 1...25 {
            standing.append(standing[0])
        }
        let standingAni = SKAction.animate(with: standing, timePerFrame: 0.1)
        self.run(SKAction.repeatForever(standingAni))
    }
    
}
