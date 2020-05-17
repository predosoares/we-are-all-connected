//
//  LiveViewController2.swift
//  BookCore
//
//  Created by Pedro Soares on 13/05/20.
//

import Foundation
import UIKit
import SpriteKit
import PlaygroundSupport

@objc(BookCore_LiveViewController)
public class LiveViewController4: UIViewController, PlaygroundLiveViewMessageHandler, PlaygroundLiveViewSafeAreaContainer {
        
    var scene: GameScene4!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view = SKView(frame: .zero)
        
        if let view = self.view as? SKView {
            scene = GameScene4()
            
            view.presentScene(scene)
        }
    }
    
    /*
    public func liveViewMessageConnectionOpened() {
        // Implement this method to be notified when the live view message connection is opened.
        // The connection will be opened when the process running Contents.swift starts running and listening for messages.
    }
    */

    /*
    public func liveViewMessageConnectionClosed() {
        // Implement this method to be notified when the live view message connection is closed.
        // The connection will be closed when the process running Contents.swift exits and is no longer listening for messages.
        // This happens when the user's code naturally finishes running, if the user presses Stop, or if there is a crash.
    }
    */

    public func receive(_ message: PlaygroundValue) {
        // Implement this method to receive messages sent from the process running Contents.swift.
        // This method is *required* by the PlaygroundLiveViewMessageHandler protocol.
        // Use this method to decode any messages sent as PlaygroundValue values and respond accordingly.
        
    }
}
