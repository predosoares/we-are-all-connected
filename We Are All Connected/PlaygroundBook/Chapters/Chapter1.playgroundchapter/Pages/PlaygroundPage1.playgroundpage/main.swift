/*:
 New Perspective
 =================
 
 **Welcome** space traveler! 👨‍🚀
 
 In this *self transcending intergalactic book* 🌌  we will explore the **universe**,
 or world, if you prefer that way, and at the end of it maybe you will
 understand a bit more about us.

 First, it is a common sense for humans that to understand
 the whole we need to understand the tiny pieces that is part of it.
 But it is just a perception brought by the cartesian view, that supposed
 the world it is like a machine, but let's take a closer look, it really works
 like a machine? 🤖
 
 Prepare your belts and open the windows of perception! 👁
 
  - Experiment: To learn something new we need to be receptive to the knowlegde that will be passed; so now you need to choose if you will open or not the windows of perception, this choice is in your hands.
      **Run the code** to start!

 */
//#-hidden-code
//
//  See LICENSE folder for this template’s licensing information.
//
//  Abstract:
//  The Swift file containing the source code edited by the user of this playground book.
//

import PlaygroundSupport
import SpriteKit

public enum PerceptionState {
    case Open
    case Closed
}

func perceptionWindow(state: PerceptionState) {
    guard state == .Open else { return }
    
    guard let proxy = PlaygroundPage.current.liveView as? PlaygroundRemoteLiveViewProxy else { return }
    proxy.send(.string("open"))
}

//#-end-hidden-code

perceptionWindow(state: /*#-editable-code */.Closed/*#-end-editable-code*/)
//#-code-completion(identifier, show, Closed, Open)
//#-code-completion(everything, hide)
