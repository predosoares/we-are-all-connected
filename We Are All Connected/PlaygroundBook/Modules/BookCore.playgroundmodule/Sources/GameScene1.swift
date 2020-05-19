//
//  GameScene.swift
//  BookCore
//
//  Created by Pedro Soares on 12/05/20.
//
import Foundation
import PlaygroundSupport
import SpriteKit

public class GameScene1: SKScene {
    
    public var backgroundSprite = SKSpriteNode()
    public var doorLeftSprite = SKSpriteNode()
    public var doorRightSprite = SKSpriteNode()
    
    private var fAlreadyOpen = false
    
    public override func didMove(to view: SKView) {
        self.size = UIScreen.main.bounds.size
        self.scaleMode = .aspectFill
        self.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        
        self.setupBackgroundScene()
        self.setupDoorsScene()
        
        PlaygroundPage.current.assessmentStatus = .fail(hints: ["💭 Give it a chance, try to open the windows of perception."], solution: nil)
        
        self.addSound()
    }
    
    public override func update(_ currentTime: TimeInterval) {
        
    }
    
    private func setupBackgroundScene() {
        backgroundSprite.texture = SKTexture(imageNamed: "BackgroundScene" )
        backgroundSprite.size = CGSize(width: frame.width + 15, height: frame.height + 50)
        
        backgroundSprite.zPosition = -10
        backgroundSprite.position = CGPoint(x: frame.midX, y: frame.midY)
        
        self.addChild(backgroundSprite)
        
        let rotate = SKAction.rotate(byAngle: .pi/60, duration: 2)
        let rotateBack = SKAction.rotate(byAngle: -.pi/60, duration: 2)
        let rotateGroup = SKAction.repeatForever(.sequence([rotate, rotate.reversed(), rotateBack, rotateBack.reversed()]))
        
        backgroundSprite.run(rotateGroup)
    }
    
    private func setupDoorsScene() {
        let imageLeftWidth = frame.height * 797 / 1166
        let imageRightWidth = frame.height * 917 / 1165
        
        //797 × 1166
        //917 × 1165
        
        let imageRightPadding = ( frame.height * (917 - 797 ) / 1165 ) + 3
        
        doorLeftSprite.texture = SKTexture(imageNamed: "3DDoorLeft" )
        doorLeftSprite.size = CGSize(width: imageLeftWidth, height: frame.height)
        doorLeftSprite.setScale(1.09)
        doorLeftSprite.position = CGPoint(x: frame.midX - imageLeftWidth/2, y: frame.midY)

        self.addChild(doorLeftSprite)

        print(frame.height)
        
        doorRightSprite.texture = SKTexture(imageNamed: "3DDoorRight" )
        doorRightSprite.size = CGSize(width: imageRightWidth, height: frame.height)
        doorRightSprite.setScale(1.09)
        doorRightSprite.position = CGPoint(x: frame.midX + imageRightWidth/2 - imageRightPadding, y: frame.midY)

        self.addChild(doorRightSprite)
    }
    
    public func openDoor() {
        if ( fAlreadyOpen == true ) { return }
        
        let imageLeftWidth = frame.height * 738 / 1113
        let imageRightWidth = frame.height * 856 / 1113
        
        let moveLeft = SKAction.moveTo(x: doorLeftSprite.position.x - imageLeftWidth, duration: 4)
        moveLeft.timingMode = SKActionTimingMode.easeIn
        
        doorLeftSprite.run(moveLeft)
        
        let moveRight = SKAction.moveTo(x: doorRightSprite.position.x + imageRightWidth, duration: 4)
        moveRight.timingMode = SKActionTimingMode.easeIn
        
        doorRightSprite.run(moveRight)
        
        fAlreadyOpen = true
        PlaygroundPage.current.assessmentStatus = .pass(message: " **Great!** When you're ready, go to the [**Next Page**](@next)!")
    }
    
    private func addSound() {
        
        let backgroundSound = SKAudioNode(fileNamed: "Eternal_Structures")
        addChild(backgroundSound)
        
        backgroundSound.run(SKAction.changeVolume(by: -0.90, duration: 0))
        backgroundSound.run(SKAction.play())
    }
}
