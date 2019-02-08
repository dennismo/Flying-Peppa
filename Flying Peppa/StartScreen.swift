//
//  StartScreen.swift
//  Flying Peppa
//
//  Created by Dennis Mo on 2/7/19.
//  Copyright © 2019 Dennis Mo. All rights reserved.
//

import Foundation
import SpriteKit


class StartScene: SKScene {
    
    
    @objc func startGame(){
        let skView = view
        let scene = GameScene(size: view?.bounds.size ?? CGSize(width:100,height:100))
        skView?.ignoresSiblingOrder = true
        skView?.showsFPS = true
        skView?.showsNodeCount = true
        scene.scaleMode = .resizeFill
        skView?.presentScene(scene)
    }
    
    
    override func didMove(to view: SKView){
        var start:UIButton = UIButton(type: .roundedRect)
        start.setTitle("START", for: .normal)
        start.setTitleColor(UIColor.blue, for: .normal)
        start.sizeToFit()
        start.frame = CGRect(x:view.bounds.maxX/2 - 60,
                             y:view.bounds.maxX/2 + 60,
                             width:100,height:50)
        
        view.addSubview(start)
        backgroundColor = .white
        start.addTarget(self, action: #selector(startGame), for: .touchUpInside)
    }
    
}

