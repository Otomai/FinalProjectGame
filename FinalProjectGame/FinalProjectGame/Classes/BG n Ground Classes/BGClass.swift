//
//  BGClass.swift
//  FinalProjectGame
//
//  Created by Tristan Garzon on 2018-04-23.
//  Copyright © 2018 Tristan Garzon. All rights reserved.
//

import SpriteKit

class BGClass: SKSpriteNode {
    
    func moveBG(camera: SKCameraNode) {
        if self.position.x + self.size.width < camera.position.x {
            self.position.x += self.size.width * 3;
        }
    }
    
    
}
