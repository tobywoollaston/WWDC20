import UIKit

public class XORView: UIView {
    
    private let nn = NeuralNetwork(2,4,1,0.1)
    private let inputs: [[Float]] = [[0,0],[1,0],[0,1],[1,1]]
    private let targets: [[Float]] = [[0],[1],[1],[0]]
    private let items = 80
    
    public init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 400, height: 400))
        self.backgroundColor = .red
        
        Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(train), userInfo: nil, repeats: true)
    }
    
    @objc func train() {
        for _ in 1...50{
            let ran = Int.random(in: 0...3)
            nn.train(inputs[ran], targets[ran])
        }
        self.setNeedsDisplay()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let itemSize = Int(rect.width)/items
        for j in 0..<items {
            for i in 0..<items {
                let square = UIBezierPath(rect: CGRect(x: i * itemSize, y: j * itemSize, width: itemSize, height: itemSize))
                let input: [Float] = [Float(i)/Float(items), Float(j)/Float(items)]
                UIColor(white: CGFloat(nn.predict(input)[0]), alpha: 1).setFill()
                square.fill()
            }
        }
    }
    
}

