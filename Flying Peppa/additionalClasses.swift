//
//  additionalClasses.swift
//  Flying Peppa
//
//  Created by Dennis Mo on 2018-08-20.
//  Copyright © 2018 Dennis Mo. All rights reserved.
//

import Foundation
import SpriteKit

func +(left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x + right.x, y: left.y + right.y)
}

func -(left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x - right.x, y: left.y - right.y)
}

func *(point: CGPoint, scalar: CGFloat) -> CGPoint {
    return CGPoint(x: point.x * scalar, y: point.y * scalar)
}

func /(point: CGPoint, scalar: CGFloat) -> CGPoint {
    return CGPoint(x: point.x / scalar, y: point.y / scalar)
}
func random() -> CGFloat {
    return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
}

func random(min: CGFloat, max: CGFloat) -> CGFloat {
    return random() * (max - min) + min
}

let peppaPigTexture1 = SKTexture(imageNamed: "peppaPig1")
let peppaSize = CGSize(width: 100, height: 100)
let peppaPigAtlas = SKTextureAtlas(named: "peppaAnimate")
var peppaFrames = [SKTexture]()
let wandUp = SKTexture(imageNamed: "Wand2")
let wandDown = SKTexture(imageNamed: "Wand1")
let wandSize = CGSize(width: 150, height: 400)

let backgroundTexture = SKTexture(imageNamed: "peppaBackground2")
let foregroundTexture = SKTexture(imageNamed: "Foreground1")


struct PhysicsCategory{
    static let None: UInt32 = 0b0
    static let All : UInt32 = UInt32.max
    static let Pig : UInt32 = 0b1
    static let Wand: UInt32 = 0b10
    static let Ground:UInt32 = 0b100
}

class peppaClass: SKSpriteNode{
    var fall = false
    
    func flapWings() {
        let flap = SKAction.animate(with: peppaFrames, timePerFrame: 0.05)
        let flaps = SKAction.repeatForever(flap)
        self.run(flaps)
    }
    
}

class wandClass: SKSpriteNode{
    
}

