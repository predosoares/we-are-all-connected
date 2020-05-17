//
//  GameScene.swift
//  BookCore
//
//  Created by Pedro Soares on 12/05/20.
//
import PlaygroundSupport
import Foundation
import SpriteKit

public class GameScene4: SKScene {
    
    public var backgroundSprite = SKSpriteNode()
    public var avatarSprite = SKSpriteNode()
    
    public var label1Sprite: SKLabelNode = SKLabelNode()
    public var label2Sprite: SKLabelNode = SKLabelNode()
    public var label3Sprite: SKLabelNode = SKLabelNode()

    
    public override func didMove(to view: SKView) {
        self.size = UIScreen.main.bounds.size
        self.scaleMode = .aspectFill
        self.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        
        self.setupBackgroundScene()
        self.setupAvatar()
        self.setupTextLabel1()
        self.setupTextLabel2()
        //self.addSound()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(5)) {
             PlaygroundPage.current.assessmentStatus = .pass(message: "I am very happy that you got here and read the whole book! 😁 Now I have a mission for you, if you really liked the experience share it with others. ")
        }
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
    
    private func setupTextLabel1() {
        label1Sprite.text = "Hi, my name is Pedro 🇧🇷"
        //labelSprite.fontName = "Helvetica-BOLD"
        label1Sprite.horizontalAlignmentMode = .center
        label1Sprite.lineBreakMode = NSLineBreakMode.byCharWrapping
        label1Sprite.fontSize = 30
        label1Sprite.fontColor = .white
        label1Sprite.position = CGPoint(x: frame.midX, y: frame.midY + 100)
        
        self.addChild(label1Sprite)
    }
    
    private func setupTextLabel2() {
        label2Sprite.text = "Thanks for reading my"
        label2Sprite.horizontalAlignmentMode = .center
        label2Sprite.lineBreakMode = NSLineBreakMode.byCharWrapping
        label2Sprite.fontSize = 30
        label2Sprite.numberOfLines = 0
        label2Sprite.fontColor = .white
        label2Sprite.preferredMaxLayoutWidth = 400
        label2Sprite.position = CGPoint(x: frame.midX, y: frame.midY - 100)
        
        self.addChild(label2Sprite)
        
        label3Sprite.text = "playground book"
        label3Sprite.horizontalAlignmentMode = .center
        label3Sprite.lineBreakMode = NSLineBreakMode.byCharWrapping
        label3Sprite.fontSize = 30
        label3Sprite.numberOfLines = 0
        label3Sprite.fontColor = .white
        label3Sprite.preferredMaxLayoutWidth = 400
        label3Sprite.position = CGPoint(x: frame.midX, y: frame.midY - 140)
        
        self.addChild(label3Sprite)
    }
    
    private func setupAvatar() {
        let avatartWidth = frame.height * 325 / 356
        
        avatarSprite.texture = SKTexture(imageNamed: "Memoji" )
        avatarSprite.size = CGSize(width: avatartWidth/5, height: frame.height/5)
        
        avatarSprite.position = CGPoint(x: frame.midX, y: frame.midY)
        self.addChild(avatarSprite)
    }
    
    public func addSound() {
        
        let backgroundSound = SKAudioNode(fileNamed: "Dana")
        addChild(backgroundSound)
        
        backgroundSound.run(SKAction.play())
    }
}
