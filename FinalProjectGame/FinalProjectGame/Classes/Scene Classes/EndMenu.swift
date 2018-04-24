//
//  EndMenu.swift
//  FinalProjectGame
//
//  Created by Tristan Garzon on 2018-04-24.
//  Copyright © 2018 Tristan Garzon. All rights reserved.
//

import SpriteKit

class EndMenu: SKScene {

    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        for touch in touches{
            let location = touch.location(in: self);
            
            if atPoint(location).name == "Playagain" {
                if let scene = GameplayScene(fileNamed: "GameplayScene") {
                    // Set the scale mode to scale to fit the window
                    scene.scaleMode = .aspectFill
                    
                    // Present the scene
                    view!.presentScene(scene,transition: SKTransition.doorsOpenVertical(withDuration: TimeInterval(2)));
                }
            }
        }
    }
}
