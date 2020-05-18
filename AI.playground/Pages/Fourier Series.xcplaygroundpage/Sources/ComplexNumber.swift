import Foundation
import UIKit

class ComplexNumber {
    var re: CGFloat
    var im: CGFloat
    var freq: CGFloat?
    var amp: CGFloat?
    var phase: CGFloat?
    init(re: CGFloat, im: CGFloat) {
        self.re = re
        self.im = im
    }
    func add(_ c: ComplexNumber) {
        self.re += c.re
        self.im += c.im
    }
    static func mult(_ a: ComplexNumber, _ b: ComplexNumber) -> ComplexNumber {
        let re = a.re*b.re - a.im*b.im
        let im = a.re*b.im + a.im*b.re
        return ComplexNumber(re: re, im: im)
    }
}
