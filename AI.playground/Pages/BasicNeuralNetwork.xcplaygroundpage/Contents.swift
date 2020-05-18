//: [Previous](@previous)
import PlaygroundSupport
/*:
 # Neural Networks
 
 The final technique to make robots smarter is Neural Networks
 
 Neural Networks was aimed to mimic how neurons fire in the brain, and using supervised learning, the neural network can learn how to decide an ouput
 
 Here we will train the neural network to learn whether to output black or white at a specific location on the screen
 
 Lets start with th famous XOR problem. XOR will only output true when either of the inputs is true, but not if both are true. To represent this each corner will represent a possible input. Those inputs and outputs are:
 
 * `(0,0)` -> `black`
 * `(0,1)` -> `white`
 * `(1,0)` -> `white`
 * `(1,1)` -> `black`
 
 We can see these inputs defined below. The targets are also below. We define the Neural Network as 2 inputs, from the coordinates, 4 neurons in the hidden layer, 1 output for black or white, 0.1 learning rate which is how slowly the brain will adjust its value
 */
let nn = NeuralNetwork(2,4,1,0.1)
let inputs: [[Float]] = [[0,0],[1,0],[0,1],[1,1]]
let targets: [[Float]] = [[0],[1],[1],[0]]
PlaygroundPage.current.liveView = View(nn, inputs, targets)
/*:
 Lets change it slightly to see what a neural network can learn. Lets try to make the centre black and the rest of the output white. To do that we will need to change a few things.
 
 Define a Neural Network with 2 inputs, 12 neurons in the hidden layer, and 1 output, with a learning rate of 0.3
 
 i.e. `NeuralNetwork(2,12,1,0.3)`
 
 The inputs should be:
 
 `[[0,1],[0.5,0.5],[1,0],[0,0],[1,1],[0,0.5],[1,0.5],[0.5,0],[0.5,1]]`
 
 The targets should be:
 
 `[[1],[0],[1],[1],[1],[1],[1],[1],[1]]`
 
 ### Applications:
 
 Neural Networks can be used to identify objects in images, this has already been used in self-driving cars.
 */
