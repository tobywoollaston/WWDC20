import Foundation

public class NeuralNetwork {
    
    private let inputN: Int
    private let hiddenN: Int
    private let outputN: Int
    
    private let weights_input_to_hidden: Matrix
    private let weights_hidden_to_output: Matrix
    
    private let bias_hidden: Matrix
    private let bias_output: Matrix
    
    private let learningRate: Float
    
    public init(_ inputN: Int, _ hiddenN: Int, _ outputN: Int, _ learningRate: Float) {
        self.inputN = inputN
        self.hiddenN = hiddenN
        self.outputN = outputN
        
        self.weights_input_to_hidden = Matrix(self.hiddenN, self.inputN)
        self.weights_input_to_hidden.randomise()
        
        self.weights_hidden_to_output = Matrix(self.outputN, self.hiddenN)
        self.weights_hidden_to_output.randomise()
        
        self.bias_hidden = Matrix(self.hiddenN, 1)
        self.bias_hidden.randomise()
        self.bias_output = Matrix(self.outputN, 1)
        self.bias_output.randomise()
        
        self.learningRate = learningRate
    }
    
    public func predict(_ inputArr: [Float]) -> [Float] {
        
        let input = Matrix(inputArr)
        let hidden = Matrix.dotproduct(self.weights_input_to_hidden, input)
        hidden.add(self.bias_hidden)
        hidden.map(sigmoid.actFunc)
        
        let output = Matrix.dotproduct(self.weights_hidden_to_output, hidden)
        output.add(self.bias_output)
        output.map(sigmoid.actFunc)
        
        return output.toArray()
    }
    
    public func train(_ inputArr: [Float], _ targetArr: [Float]) {
        
        let input = Matrix(inputArr)
        let target = Matrix(targetArr)
        
        let hidden = Matrix.dotproduct(self.weights_input_to_hidden, input)
        hidden.add(self.bias_hidden)
        hidden.map(sigmoid.actFunc)
        
        let output = Matrix.dotproduct(self.weights_hidden_to_output, hidden)
        output.add(self.bias_output)
        output.map(sigmoid.actFunc)
        
        // output adjust
        let output_error = Matrix.subtract(target, output)
        
        let gradients = Matrix.map(output, sigmoid.devFunc)
        gradients.multiply(output_error)
        gradients.scale(learningRate)
        
        let hidden_T = Matrix.transpose(hidden)
        let whto_deltas = Matrix.dotproduct(gradients, hidden_T)
        
        self.weights_hidden_to_output.add(whto_deltas)
        self.bias_output.add(gradients)
        
        //hidden layer adjust
        let whto_T = Matrix.transpose(self.weights_hidden_to_output)
        let hidden_error = Matrix.dotproduct(whto_T, output_error)
        
        let hidden_gradient = Matrix.map(hidden, sigmoid.devFunc)
        hidden_gradient.multiply(hidden_error)
        hidden_gradient.scale(learningRate)
        
        let inputs_T = Matrix.transpose(input)
        let wito_deltas = Matrix.dotproduct(hidden_gradient, inputs_T)
        
        self.weights_input_to_hidden.add(wito_deltas)
        self.bias_hidden.add(hidden_gradient)
        
    }
    
}
