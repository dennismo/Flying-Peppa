//
//  StartScreen.swift
//  Flying Peppa
//
//  Created by Dennis Mo on 2/7/19.
//  Copyright © 2019 Dennis Mo. All rights reserved.
//

import Foundation
import SpriteKit

var StartImage = SKTexture(imageNamed: "PeppaStart")
var StartImageIcon = SKTexture(imageNamed: "PeppaStartIcon")

class StartScene: SKScene {
    
    var start:UIButton = UIButton(type: .roundedRect)
    var background1 = UIImageView()
    @objc func startGame(){
        let skView = view
        let scene = GameScene(size: view?.bounds.size ?? CGSize(width:100,height:100))
        skView?.ignoresSiblingOrder = true
        skView?.showsFPS = true
        skView?.showsNodeCount = true
        scene.scaleMode = .resizeFill
        scene.backgroundColor = .white
        skView?.presentScene(scene)
        start.removeFromSuperview()
        background1.removeFromSuperview()
    }
    
    
    override func didMove(to view: SKView){
        background1.bounds = view.bounds
        background1.frame = CGRect(x: view.bounds.maxX/2 - StartImage.size().width/2,
                                   y: view.bounds.maxY/4 - StartImage.size().height/2 + 70,
                                   width: StartImage.size().width,
                                   height: StartImage.size().height)
        var previousCenter = background1.center
        var transform = CGAffineTransform(scaleX: 0.13, y: 0.13)
        background1.frame = background1.frame.applying(transform)
        background1.center = previousCenter
        background1.image = UIImage(named: "PeppaStart")
        start.setImage(UIImage(named: "PeppaStartIcon"), for: .normal)
        start.titleLabel?.font = UIFont.systemFont(ofSize: 40)
        start.sizeToFit()
        var startSize = StartImageIcon.size().applying(transform)
        start.frame = CGRect(origin: CGPoint(x: view.bounds.maxX / 2 - startSize.width/2, y: view.bounds.maxY/2 + 100), size: startSize)
        
        view.addSubview(start)
        view.addSubview(background1)
        backgroundColor = .white
        start.addTarget(self, action: #selector(startGame), for: .touchUpInside)
    }
    
}

