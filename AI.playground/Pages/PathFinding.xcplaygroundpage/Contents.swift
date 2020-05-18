//: [Previous](@previous)
import PlaygroundSupport
/*:
 # Navigation
 
 For a robot to move itself, it must be able to find a path between 2 points
 
 Lets test a few different algorithms which can do that
 
 When you run the algorithms, think about what ones happen quicker, do they always find the shortest route between two points?
 
 The start point is the green square on the grid, and the end point is the red square on the grid
 To move them simply click on the square and drag it to where you wish
 
 To add walls for the path to go around, click and drag on the white squares, you will know its a wall when the sqaure turns blue
 
 To clear the grid, hit the **Clear Board** button
 
 To change the algorithm used click the button to the left and the name will change between:
 
 * Dijkstra's Algorithm
 * A* Search
 * Greedy Best First Search
 
 To see the path the algorithm will take hit the **Visualise Path Finding** button
 
 You can also load a grid pattern to use and test the algorithms

 In the brackets in the code below you can either enter:
 
 * `.blank` which will load a blank grid with no walls
 * `.basicRandomMaze` which will load a randomly generated maze
 * `.zigZag` which will load a zig zag pattern
 * `.mazeTest` which will load a maze to test
 
 */
PlaygroundPage.current.liveView = PathFinding(.basicRandomMaze)
//: [Next](@next)
