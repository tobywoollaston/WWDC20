//: [Previous](@previous)

import PlaygroundSupport
import SpriteKit

/*:
 # Basic Controls
 
 Here we'll learn how we can control how robot 
 */

let robot = BasicRobot()

robot.addAction(.forward)
robot.addAction(.backward)

PlaygroundPage.current.liveView = BasicControls(robot)

class sp: SKSpriteNode {
    init() {
        super.init(imageNamed: "Mini-Robot-Standing-1.png")
    }
}

//: [Next](@next)
