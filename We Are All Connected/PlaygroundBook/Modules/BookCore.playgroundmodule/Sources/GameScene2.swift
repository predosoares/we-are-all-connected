//
//  GameScene.swift
//  BookCore
//
//  Created by Pedro Soares on 12/05/20.
//
import Foundation
import PlaygroundSupport
import SpriteKit

public class GameScene2: SKScene {
    
    private var backgroundSprite: SKSpriteNode = SKSpriteNode()
    private var leftArmSprite: SKSpriteNode = SKSpriteNode()
    private var rightArmSprite: SKSpriteNode = SKSpriteNode()
    
    private var focusedSprite: SKSpriteNode = SKSpriteNode()
    
    private var arrowLeftSprite: SKSpriteNode = SKSpriteNode()
    private var arrowRightSprite: SKSpriteNode = SKSpriteNode()
    
    private var textDisplaySprite: SKSpriteNode = SKSpriteNode()
    
    // Atom sprite components
    private var atomSprite: SKSpriteNode = SKSpriteNode()
    private var eletronSprite: SKSpriteNode = SKSpriteNode()
    private var protonSprite: SKSpriteNode = SKSpriteNode()
    private var atomTextSprite: SKSpriteNode = SKSpriteNode()
    
    // Cells sprite component
    private var cellsSprite: SKSpriteNode = SKSpriteNode()
    private var cellsTextSprite: SKSpriteNode = SKSpriteNode()
    
    // Trees sprite component
    private var treesSprite: SKSpriteNode = SKSpriteNode()
    private var treesTextSprite: SKSpriteNode = SKSpriteNode()
    
    // Control variables
    private var indexSprite: Int = 0
    private var listSprite: [SKSpriteNode] = []
    private var listTextSprite: [SKSpriteNode] = []
    private var listVisitedSprite: [Bool] = []
    private var passed: Bool = false
    
    public override func didMove(to view: SKView) {
        self.size = UIScreen.main.bounds.size
        self.scaleMode = .aspectFill
        self.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        
        self.setupBackgroundSprite()
        self.setupArmsSprite()
        self.setupAtomSprite()
        self.setupCellsSprite()
        self.setupTreesSprite()
        self.addSound()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
            self.setupArrowsSprite()
            self.setFocusedSprite(node: self.atomSprite,textDisplayNode: self.atomTextSprite)
        }
        
        PlaygroundPage.current.assessmentStatus = .fail(hints: ["Look your apple watch to see more information about the connections and click in the arrows to see others."], solution: nil)
    }
    
    private func setupBackgroundSprite() {
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
    
    private func setupArmsSprite() {
        leftArmSprite.texture = SKTexture(imageNamed: "3DLeftArm" )
        leftArmSprite.size = CGSize(width: frame.width*(4/11) * 1.3, height: frame.height*(5/28) * 1.3)
        leftArmSprite.position = CGPoint(x: frame.midX - (frame.width*(1.6/3) * 1.3)/3.2 - 400, y: frame.midY - 200 - 20)
        
        self.addChild(leftArmSprite)
        
        let moveLeft = SKAction.moveTo(x: frame.midX - (frame.width*(1.6/3) * 1.3)/3.2, duration: 2)
        moveLeft.timingMode = SKActionTimingMode.easeOut

        leftArmSprite.run(moveLeft)
        
        rightArmSprite.texture = SKTexture(imageNamed: "3DRightArm" )
        rightArmSprite.size = CGSize(width: frame.width*(1.6/3) * 1.3, height: (frame.height)*(2/3) * 1.3)
        rightArmSprite.position = CGPoint(x: frame.midX + (frame.width*(1.6/3) * 1.3)/3.2 + 400, y: frame.midY - 144 - 15)
        
        self.addChild(rightArmSprite)
        
        let move = SKAction.moveTo(x: frame.midX - 5 + (frame.width*(1.6/3) * 1.3)/3.2, duration: 2)
        move.timingMode = SKActionTimingMode.easeOut

        rightArmSprite.run(move)
        
        let scaleUp = SKAction.scale(to: 1.02, duration: 2)
        let scaleBack = SKAction.scale(to: 1, duration: 2)
        rightArmSprite.run(SKAction.repeatForever(.sequence([scaleUp,scaleBack])))
    }
    
    private func setFocusedSprite(node: SKSpriteNode, textDisplayNode: SKSpriteNode) {
        // focusedSprite só entrará na seleção uma única vez
        if ( focusedSprite.children.count == 0 ) {
            focusedSprite.position = CGPoint(x: frame.midX, y: frame.midY - 20)
            self.addChild(focusedSprite)
        }
        
        node.setScale(0.1)
        node.alpha = 0.0
        textDisplayNode.alpha = 0.0
        
        self.focusedSprite.removeAllChildren()
        self.focusedSprite.addChild(node)
        self.focusedSprite.addChild(textDisplayNode)
        
        let scaleUp = SKAction.scale(to: 1, duration: 2)
        scaleUp.timingMode = SKActionTimingMode.easeOut
        node.run(scaleUp)
        
        let rotate = SKAction.rotate(byAngle: .pi/30, duration: 2)
        let rotateBack = SKAction.rotate(byAngle: -.pi/30, duration: 2)
        let rotateGroup = SKAction.repeatForever(.sequence([rotate, rotate.reversed(), rotateBack, rotateBack.reversed()]))
        
        node.run(rotateGroup)
        
        let fadeIn = SKAction.fadeIn(withDuration: 1)
        fadeIn.timingMode = SKActionTimingMode.easeOut
        
        textDisplayNode.run(fadeIn)
        node.run(fadeIn)
        
        let textLabel = SKLabelNode(text: self.currentTimeString() )
        textLabel.fontName = "Helvetica-Neue-BOLD"
        textLabel.fontSize = 12
        textLabel.color = .gray
        textLabel.position = CGPoint(x: 35, y: 62.5)
        textDisplayNode.removeAllChildren()
        textDisplayNode.addChild(textLabel)
    }
    
    private func currentTimeString() -> String {
        let df = DateFormatter()
        df.dateFormat = "hh:mm"
        return df.string(from: Date())
    }
    
    private func setupAtomSprite(){
        atomSprite.position = CGPoint(x: 0, y: 0)
        
        
        eletronSprite.texture = SKTexture(imageNamed: "Eletron" )
        eletronSprite.size = CGSize(width: 150, height: 150)
        eletronSprite.position = CGPoint(x: 0, y: 0)
        
        atomSprite.addChild(eletronSprite)
        
        let rotation = SKAction.rotate(byAngle: .pi*2, duration: 6)
        eletronSprite.run(SKAction.repeatForever(rotation))
        
        
        
        protonSprite.texture = SKTexture(imageNamed: "Proton" )
        protonSprite.size = CGSize(width: 50, height: 50)
        protonSprite.position = CGPoint(x: 0, y: 0)
        
        atomSprite.addChild(protonSprite)
        
        listSprite.append(atomSprite)
        self.setupAtomTextSprite()
        self.listVisitedSprite.append(false)
    }
    
    private func setupAtomTextSprite() {
        atomTextSprite.texture = SKTexture(imageNamed: "3DAtomTextDisplay" )
        atomTextSprite.size = CGSize(width: 195, height: 200)
        atomTextSprite.position = CGPoint(x: 5, y: 210)
        
        listTextSprite.append(atomTextSprite)
    }
    
    private func setupCellsSprite() {
        cellsSprite.texture = SKTexture(imageNamed: "Cells" )
        cellsSprite.size = CGSize(width: 140, height: 155)
        cellsSprite.position = CGPoint(x: 0, y: 0)
        
        listSprite.append(cellsSprite)
        self.setupCellsTextSprite()
        self.listVisitedSprite.append(false)
    }
    
    private func setupCellsTextSprite() {
        cellsTextSprite.texture = SKTexture(imageNamed: "3DCellsTextDisplay" )
        cellsTextSprite.size = CGSize(width: 195, height: 200)
        cellsTextSprite.position = CGPoint(x: 5, y: 210)
        
        listTextSprite.append(cellsTextSprite)
    }
    
    private func setupTreesSprite() {
        treesSprite.texture = SKTexture(imageNamed: "Trees" )
        treesSprite.size = CGSize(width: 150, height: 120)
        treesSprite.position = CGPoint(x: 0, y: 0)
        
        listSprite.append(treesSprite)
        self.setupTreesTextSprite()
        self.listVisitedSprite.append(false)
    }
    
    private func setupTreesTextSprite() {
        treesTextSprite.texture = SKTexture(imageNamed: "3DTreesTextDisplay" )
        treesTextSprite.size = CGSize(width: 195, height: 200)
        treesTextSprite.position = CGPoint(x: 5, y: 210)
        
        listTextSprite.append(treesTextSprite)
    }
    
    private func setupArrowsSprite() {
        let fadeIn = SKAction.fadeIn(withDuration: 0.3)
        fadeIn.timingMode = SKActionTimingMode.easeIn
        
        arrowLeftSprite.texture = SKTexture(imageNamed: "3DArrowLeft" )
        arrowLeftSprite.size = CGSize(width: 45, height: 60)
        arrowLeftSprite.position = CGPoint(x:frame.midX - 160, y: frame.midY - 20)
        arrowLeftSprite.name = "previous"
        arrowLeftSprite.alpha = 0.0
        
        self.addChild(arrowLeftSprite)
        
        arrowLeftSprite.run(fadeIn)
        
        
        arrowRightSprite.texture = SKTexture(imageNamed: "3DArrowRight" )
        arrowRightSprite.size = CGSize(width: 45, height: 60)
        arrowRightSprite.position = CGPoint(x: frame.midX + 160, y: frame.midY - 20)
        arrowRightSprite.name = "next"
        arrowRightSprite.alpha = 0.0

        self.addChild(arrowRightSprite)
        
        arrowRightSprite.run(fadeIn)
        
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        
        if let touch = touches.first {
            let location = touch.location(in: self)
            let touchedNode = self.nodes(at: location).first
            
            if (touchedNode?.name == "previous"){
                indexSprite = ( indexSprite - 1 ) < 0 ? listSprite.count - 1 :  indexSprite - 1
                
                listVisitedSprite[indexSprite] = true
                let sprite = listSprite[indexSprite]
                let textDisplaySprite = listTextSprite[indexSprite]
                self.setFocusedSprite(node: sprite, textDisplayNode: textDisplaySprite)
                checkHaveSeenAll()
            }
            else if (touchedNode?.name == "next"){
                indexSprite = ( indexSprite + 1 ) % listSprite.count

                listVisitedSprite[indexSprite] = true
                let sprite = listSprite[indexSprite]
                let textDisplaySprite = listTextSprite[indexSprite]
                self.setFocusedSprite(node: sprite, textDisplayNode: textDisplaySprite)
                checkHaveSeenAll()
            }
        }
    }
    
    private func checkHaveSeenAll(){
        guard passed == false else { return }
        
        for sprite in listVisitedSprite {
            if ( sprite == false ){
                return
            }
        }
        
        passed = true
        PlaygroundPage.current.assessmentStatus = .pass(message: "You got it, now you're ready for the [**Next Page**](@next)!")
        
    }
    
    private func addSound() {
        
        let backgroundSound = SKAudioNode(fileNamed: "Eternal_Structures")
        addChild(backgroundSound)
        
        backgroundSound.run(SKAction.changeVolume(by: -0.90, duration: 0))
        backgroundSound.run(SKAction.play())
    }
}
