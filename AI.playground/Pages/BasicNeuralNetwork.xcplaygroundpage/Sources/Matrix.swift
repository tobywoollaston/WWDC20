import Foundation

public class Matrix {
    
    internal let rows: Int
    internal let columns: Int
    internal var data: [[Float]]
    
    public init(_ rows: Int, _ columns: Int) {
        self.rows = rows
        self.columns = columns
        self.data = [[Float]]()
        for _ in 0..<rows {
            var row = [Float]()
            for _ in 0..<columns {
                row.append(0)
            }
            self.data.append(row)
        }
    }
    
    public init(_ input: [Float]) {
        self.rows = input.count
        self.columns = 1
        self.data = [[Float]]()
        for i in 0..<input.count {
            self.data.append([input[i]])
        }
    }
    
    public func randomise() {
        for i in 0..<rows {
            for j in 0..<columns {
                self.data[i][j] = Float.random(in: -1...1)
            }
        }
    }
    
    public func log() {
        print("[")
        for i in 0..<rows-1 {
            print(" ", terminator: "")
            print(data[i], terminator: ",\n")
        }
        print(" ", terminator: "")
        print(data[data.count-1])
        print("]")
    }
    
    //func square(_ x: Float) -> Float {
    //    return powf(x, 2)
    //}
    //m1.map { (x) -> Float in
    //    return powf(x, 2)
    //}
    //m1.map(square(_:))
    public func map(_ function: (Float) -> Float) {
        for i in 0..<rows {
            for j in 0..<columns {
                self.data[i][j] = function(self.data[i][j])
            }
        }
    }
    
    public static func map(_ a: Matrix, _ function: (Float) -> Float) -> Matrix {
        let result = Matrix(a.rows, a.columns)
        for i in 0..<result.rows {
            for j in 0..<result.columns {
                result.data[i][j] = function(a.data[i][j])
            }
        }
        return result
    }
    
    public func toArray() -> [Float] {
        var output = [Float]()
        for i in 0..<rows {
            for j in 0..<columns {
                output.append(self.data[i][j])
            }
        }
        return output
    }
    
    public func scale(_ factor: Float) {
        for i in 0..<rows {
            for j in 0..<columns {
                self.data[i][j] *= factor
            }
        }
    }
    
    public func multiply(_ b: Matrix) {
        // hadamard product
        for i in 0..<rows {
            for j in 0..<columns {
                self.data[i][j] *= b.data[i][j]
            }
        }
    }
    
    public func add(_ value: Float) {
        for i in 0..<rows {
            for j in 0..<columns {
                self.data[i][j] += value
            }
        }
    }
    
    public func add(_ value: Matrix) {
        if self.rows != value.rows && self.columns != value.columns {
            print("matrices must be the same shape")
            return
        }
        for i in 0..<rows {
            for j in 0..<columns {
                self.data[i][j] += value.data[i][j]
            }
        }
    }
    
    public static func transpose(_ a: Matrix) -> Matrix {
        let result = Matrix(a.columns, a.rows)
        for i in 0..<a.rows {
            for j in 0..<a.columns {
                result.data[j][i] = a.data[i][j]
            }
        }
        return result
    }
    
    public static func subtract(_ a: Matrix, _ b: Matrix) -> Matrix {
        if a.rows != b.rows && a.columns != b.columns {
            print("matrices must be the same shape")
            return Matrix(-1,-1)
        }
        let output = Matrix(a.rows, b.columns)
        for i in 0..<output.rows {
            for j in 0..<output.columns {
                output.data[i][j] = a.data[i][j] - b.data[i][j]
            }
        }
        return output
    }
    
    public static func dotproduct(_ a: Matrix, _ b: Matrix) -> Matrix {
        if a.columns != b.rows {
            print("cols of a must match rows of b")
            return Matrix(-1,-1)
        }
        let result = Matrix(a.rows, b.columns)
        for i in 0..<result.rows {
            for j in 0..<result.columns {
                var sum: Float = 0
                for k in 0..<a.columns {
                    sum += a.data[i][k] * b.data[k][j]
                }
                result.data[i][j] = sum
            }
        }
        return result
    }
    
}
