import Foundation

public let sigmoid = ActivationFunction({ (x) -> Float in
    return 1 / (1 + powf(Float(M_E), -x))
}) { (y) -> Float in
    return y * (1 - y)
}

public class ActivationFunction {
    
    public let actFunc: (Float) -> Float
    public let devFunc: (Float) -> Float
    
    public init(_ actFunc: @escaping (Float) -> Float, _ devFunc: @escaping (Float) -> Float) {
        self.actFunc = actFunc
        self.devFunc = devFunc
    }
}
