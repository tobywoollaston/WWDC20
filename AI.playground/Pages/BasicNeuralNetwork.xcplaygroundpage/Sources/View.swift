import UIKit

public class View: UIView {
    
    private let nn: NeuralNetwork
    private let inputs: [[Float]]
    private let targets: [[Float]]
    
    private let items = 60
    
    public init(_ nn: NeuralNetwork, _ inputs: [[Float]], _ targets: [[Float]]) {
        self.nn = nn
        self.inputs = inputs
        self.targets = targets
        super.init(frame: CGRect(x: 0, y: 0, width: 600, height: 600))
        self.backgroundColor = .red
        
        Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(train), userInfo: nil, repeats: true)
    }
    
    @objc func train() {
        for _ in 1...50{
            let ran = Int.random(in: 0..<inputs.count)
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
        
        var stringToDraw = "(0,0)" as NSString
        var rectToDraw = CGRect(x: 0, y:0, width: 25, height: 15)
        stringToDraw.draw(in: rectToDraw, withAttributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
        
        stringToDraw = "(1,0)" as NSString
        rectToDraw = CGRect(x: 600-25, y:0, width: 25, height: 15)
        stringToDraw.draw(in: rectToDraw, withAttributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
        
        stringToDraw = "(1,1)" as NSString
        rectToDraw = CGRect(x: 600-25, y:600-15, width: 25, height: 15)
        stringToDraw.draw(in: rectToDraw, withAttributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
        
        stringToDraw = "(0,1)" as NSString
        rectToDraw = CGRect(x: 0, y:600-15, width: 25, height: 15)
        stringToDraw.draw(in: rectToDraw, withAttributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
    }
    
}

