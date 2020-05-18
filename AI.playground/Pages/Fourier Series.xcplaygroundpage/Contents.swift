//: [Previous](@previous)
import PlaygroundSupport
/*:
 
 # Fourier Series
 
 When we want a robot to do repeated steps based on input data that repeaets it self, we can learn a function
 
 We can learn a function that using a **Fourier Series**
 
 A Fourier series is an expansion of a periodic function f(x) in terms of an infinite sum of sines and cosines
 
 To test what this looks like, on the view you can draw an image, when you stop drawing the page will take your image and repeatedly redraw your image using only circles from the Fourier series
 
 It will even mimic the speed at which you drew the image
 
 */
let scene = DrawingFourierTransform()
let view = MainView(scene)
PlaygroundPage.current.liveView = view

/*:
 ### Applications:
 
 Fourier Series has been used to develop robots that require walking patterns, this may be used on robots that take a human form and use legs and feet to walk.
 */

//: [Next](@next)
