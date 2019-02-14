//
//  GameOverScene.swift
//  Flying Peppa
//
//  Created by Dennis Mo on 2018-08-22.
//  Copyright © 2018 Dennis Mo. All rights reserved.
//

import Foundation
import SpriteKit

class GameOverScene: SKScene{
    let dino = UIImageView(image: UIImage(named: "PeppaDino"))
    init(size: CGSize, score: Int, win: Bool){
        super.init(size:size)
        self.backgroundColor = .black
        
        let gameEndLabel = SKLabelNode(fontNamed: "AvenirNextCondensed-Heavy")
        gameEndLabel.fontSize = 30
        gameEndLabel.zPosition = 2
        gameEndLabel.fontColor = .white
        gameEndLabel.position = CGPoint(x: size.width/2, y: size.height/4 * 3)
        
        if win{
            gameEndLabel.text = "WIN!"
        }
        else{
            gameEndLabel.text = "Score: \(score)"
        }
        
        addChild(gameEndLabel)
        run(SKAction.sequence([
            SKAction.wait(forDuration: 2.0),
            SKAction.run { [weak self] in
                
                guard let `self` = self else { return }
                let scene = StartScene(size: size)
                let reveal = SKTransition.crossFade(withDuration: 0.5)
                self.view?.presentScene(scene,transition: reveal)
                self.dino.removeFromSuperview()
            }
            ]))
        
    }
    override func didMove(to view: SKView) {
        let dinoSize = CGSize(width: 200, height: 300)
        dino.frame = CGRect(origin: CGPoint(x:view.frame.maxX/2 - dinoSize.width/2,y:view.frame.maxY/2 + 20 - dinoSize.height/2), size:dinoSize )
        view.addSubview(dino)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}

