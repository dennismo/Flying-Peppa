//
//  GameScene.swift
//  Flying Peppa
//
//  Created by Dennis Mo on 2018-08-20.
//  Copyright © 2018 Dennis Mo. All rights reserved.
//

import SpriteKit
import GameplayKit


class GameScene: SKScene {
    let peppa = peppaClass(texture: peppaPigTexture1)
    let wand1Up = wandClass(texture: wandUp)
    let wand1Down = wandClass(texture: wandDown)
    let wand2Up = wandClass(texture: wandUp)
    let wand2Down = wandClass(texture: wandDown)
    let background = SKSpriteNode(texture: backgroundTexture)
    let foreground1 = SKSpriteNode(texture: foregroundTexture)
    let foreground2 = SKSpriteNode(texture: foregroundTexture)
    let scoreLabel = SKLabelNode(fontNamed: "AvenirNextCondensed-Heavy")
    var wandNumber:Int = 1
    
    
    var score: Int = 0{
        didSet{
            scoreLabel.text = "\(score)"
        }
    }
    
    var wandIntervalX = CGFloat(300)
    var wandIntervalY = CGFloat(255)
    var randomWandY = CGFloat(0)
    
    override func didMove(to view: SKView) {
        
        background.size = view.bounds.size
        background.position = CGPoint(x:view.bounds.size.width / 2, y: view.bounds.height / 2)
        background.zPosition = -1
        addChild(background)
        
        scoreLabel.fontColor = .black
        scoreLabel.zPosition = 4
        scoreLabel.fontSize = 50
        scoreLabel.text = "FLAP!"
        scoreLabel.position = CGPoint(x:view.bounds.size.width / 2, y: view.bounds.height * 3 / 4)
        addChild(scoreLabel)
        
        wandIntervalX = view.bounds.size.width * 0.8
        wandIntervalY = view.bounds.size.height * 0.38
        //wandIntervalY = view.bounds.size.height * 0.38
        randomWandY = view.bounds.size.height * 0.254
        print(view.bounds.size)
        
        let foregrounds = [foreground1,foreground2]
        
        foreground1.position = CGPoint(x:view.bounds.size.height / 2, y: view.bounds.height / 16)
        foreground2.position = CGPoint(x:view.bounds.size.height * 3 / 2, y: view.bounds.height / 16)
        
        for foreground in foregrounds{
            foreground.size = CGSize(width: view.bounds.height, height: view.bounds.height / 8)
            foreground.physicsBody = SKPhysicsBody(texture: foregroundTexture, size: foreground.size)
            foreground.physicsBody?.affectedByGravity = false
            foreground.physicsBody?.velocity = CGVector(dx: -150, dy: 0)
            foreground.physicsBody?.linearDamping = 0
            foreground.physicsBody?.friction = 0
            foreground.physicsBody?.categoryBitMask = PhysicsCategory.Ground
            foreground.physicsBody?.contactTestBitMask = PhysicsCategory.None
            foreground.physicsBody?.collisionBitMask = PhysicsCategory.None
            addChild(foreground)
        }

        
        peppa.position = CGPoint(x: view.bounds.size.width / 2 - 50, y: view.bounds.size.height / 2 + 300)
        peppa.size = CGSize(width: view.bounds.size.width * 0.266, height: view.bounds.size.width * 0.266)
        peppa.physicsBody = SKPhysicsBody(texture: peppaPigTexture1, size: peppa.size)
        peppa.physicsBody?.categoryBitMask = PhysicsCategory.Pig
        peppa.physicsBody?.contactTestBitMask = 0b110
        peppa.physicsBody?.collisionBitMask = 0b110
        peppa.physicsBody?.angularDamping = 0.6
//        peppa.physicsBody?.linearDamping = 0.05
        peppa.physicsBody?.restitution = 0.7
        addChild(peppa)
        
        physicsWorld.gravity = CGVector(dx: 0, dy: -1 * view.bounds.size.height * 0.009)
        
        let wands = [wand1Up,wand1Down,wand2Up,wand2Down]
        
        
        let randomPosition1 = random(min: -100, max: 170)
        let randomPosition2 = random(min: -100, max: 170)
        
        for wand in wands{
            wand.size = CGSize(width: view.bounds.size.width * 0.4 + 10, height: view.bounds.size.height * 0.59)
            //wand.size = CGSize(width: view.bounds.size.width * 0.4, height: view.bounds.size.height * 0.59)
        }
        
        wand1Up.position = CGPoint(x: view.bounds.size.width + 170 , y: view.bounds.size.height / 2 + randomPosition1 + wandIntervalY)
        wand1Down.position = CGPoint(x: view.bounds.size.width + 170 , y: view.bounds.size.height / 2 + randomPosition1 - wandIntervalY)
        wand2Up.position = CGPoint(x: wand1Up.position.x + wandIntervalX , y: view.bounds.size.height / 2 + randomPosition2 + wandIntervalY)
        wand2Down.position = CGPoint(x: wand1Up.position.x + wandIntervalX , y: view.bounds.size.height / 2 + randomPosition2 - wandIntervalY)
        
        let wandPhysicsTexture = SKTexture(imageNamed: "WandUp1")
        
        wand1Up.physicsBody = SKPhysicsBody(texture: wandPhysicsTexture, size: wand1Up.size)
        wand2Up.physicsBody = SKPhysicsBody(texture: wandPhysicsTexture, size: wand1Up.size)
        wand1Down.physicsBody = SKPhysicsBody(texture: wandDown, size: wand1Up.size)
        wand2Down.physicsBody = SKPhysicsBody(texture: wandDown, size: wand1Up.size)
        
        for wand in wands{
            wand.zPosition = 2
            wand.physicsBody?.categoryBitMask = PhysicsCategory.Wand
            wand.physicsBody?.collisionBitMask = PhysicsCategory.None
            wand.physicsBody?.affectedByGravity = false
            wand.physicsBody?.velocity = CGVector(dx: -150, dy: 0)
            wand.physicsBody?.linearDamping = 0
            wand.physicsBody?.friction = 0
            addChild(wand)
        }
        
        
        for index in 0...5 {
            let temp = peppaPigAtlas.textureNamed("peppaPigAnimate\(index)")
            peppaFrames.append(temp)
        }
        
        peppa.flapWings()
    }
    
    func fallingAction(){
        if let velocity = peppa.physicsBody?.velocity.dy{
            if velocity < CGFloat(-330) && peppa.fall == false{
                peppa.fall = true
                let turn = SKAction.rotate(byAngle: -2, duration: 0.2)
                peppa.run(turn)
            }
        }
    }
    
    func respawnWands(wandUp: wandClass, wandDown: wandClass){
        let randomPosition = random(min: -80, max: 170)
        wandUp.position = CGPoint(x: wandIntervalX * 2, y: (view?.bounds.size.height)! / 2 + randomPosition + wandIntervalY)
        wandDown.position = CGPoint(x: wandIntervalX * 2, y: (view?.bounds.size.height)! / 2 + randomPosition - wandIntervalY)
        wandUp.physicsBody?.velocity = CGVector(dx: -150, dy: 0)
        wandDown.physicsBody?.velocity = CGVector(dx: -150, dy: 0)
    }
    
    func wandRefresh(){
        if wand1Up.position.x < -50 {
            respawnWands(wandUp: wand1Up, wandDown: wand1Down)
        }
        if wand2Up.position.x < -50 {
            respawnWands(wandUp: wand2Up, wandDown: wand2Down)
        }
    }
    
    func foregroundRefresh(){
        if foreground1.position.x < -1 * ((view?.bounds.size.height)! / 2){
            foreground1.position.x = (view?.bounds.size.height)! * 3 / 2
        }
        if foreground2.position.x < -1 * ((view?.bounds.size.height)! / 2){
            foreground2.position.x = (view?.bounds.size.height)! * 3 / 2
        }
    }
    
    
    func terminalVelocity(velocity : CGFloat){
        if let downV = peppa.physicsBody?.velocity.dy{
            if downV < velocity{
                peppa.physicsBody?.affectedByGravity = false
            }
            else{
                peppa.physicsBody?.affectedByGravity = true
            }
        }
    }
    
    func updateGameOver(){
        
        if peppa.position.x > (view?.bounds.size.width)! + 10 {
            let gameOverScene = GameOverScene(size: self.size, score: score,win: true)
            self.view?.presentScene(gameOverScene)
            return
        }
        
        if peppa.position.x < -25{
            let gameOverScene = GameOverScene(size: self.size, score: score,win: false)
            self.view?.presentScene(gameOverScene)
            return
        }
        if peppa.position.y > ((view?.bounds.height)! + 50){
            let gameOverScene = GameOverScene(size: self.size, score: score,win: false)
            self.view?.presentScene(gameOverScene)
            return
        }

    }
    
    func updateScore(){
        if wandNumber == 1{
            if (peppa.position.x < wand1Up.position.x + 3) && (peppa.position.x > wand1Up.position.x - 3) {
                wandNumber = 2
                score += 1
            }
        }
        if wandNumber == 2{
            if (peppa.position.x  < wand2Up.position.x + 3) && (peppa.position.x > wand2Up.position.x - 3) {
                score += 1
                wandNumber = 1
            }
        }
        
    }

    func createSceneContents() {
        self.backgroundColor = .black
        self.scaleMode = .aspectFit
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let unTurn = SKAction.rotate(byAngle: 2, duration: 0.1)
//        let move = SKAction.move(by: CGVector(dx: 0, dy: 80), duration: 0.1)
//        let group = SKAction.group([unTurn,move])
        
        peppa.physicsBody?.velocity = CGVector(dx: 0, dy: (view?.bounds.size.height)! * 0.6)
        
        if peppa.fall == true{
            
            peppa.run(unTurn)
        }
        else{
            //peppa.run(move)
        }
        peppa.fall = false
    
    }
    
    override func update(_ currentTime: TimeInterval) {

        fallingAction()
        terminalVelocity(velocity: -400)
        wandRefresh()
        foregroundRefresh()
        updateScore()
        updateGameOver()
    }
}

extension GameScene:SKPhysicsContactDelegate{
    func didBegin(_ contact: SKPhysicsContact) {
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask{
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        }
        else{
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
    }
}
