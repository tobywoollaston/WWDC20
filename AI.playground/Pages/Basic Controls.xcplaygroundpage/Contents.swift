//: [Previous](@previous)

import PlaygroundSupport
import SpriteKit

/*:
 # Basic Controls
 
 Here we'll learn how we can control how robot
 
 First lets create a robot
 */
let robot = BasicRobot()
/*: Then lets add some commands
 
 That can be achieved by typing `robot.addAction(.forward)`
 
 Inside the brackets there a 4 different commands you can enter
 
 * `.forward` to move the robot forward
 * `.backward` to move the robot backward
 * `.rotateLeft` to rotate the direction of the robot to the left (or by -90 degrees)
 * `.rotateRight` to rotate the direction of the robot to the right (or by +90 degrees)
 
 */
robot.addAction(.forward)

PlaygroundPage.current.liveView = BasicControls(robot)

//: Now run the Playground and watch the robot move

//: Can you collect all the coins?

//: It's a bit tiring manually entering how to make the robot move, lets look at some techniques we can use to make it easier for use. Hit the next button to continue.

//: [Next](@next)
