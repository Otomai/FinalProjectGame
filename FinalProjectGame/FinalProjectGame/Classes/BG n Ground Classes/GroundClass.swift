//
//  GroundClass.swift
//  FinalProjectGame
//
//  Created by Tristan Garzon on 2018-04-23.
//  Copyright © 2018 Tristan Garzon. All rights reserved.
//

import SpriteKit

class GroundClass: SKSpriteNode {
    
    func initializeGroundAndFloor() {
        physicsBody = SKPhysicsBody(rectangleOf: self.size);
        physicsBody?.affectedByGravity = false;
        physicsBody?.isDynamic = false;
        physicsBody?.categoryBitMask = ColliderType.GROUND;
    }
    
    
    func moveGroundsOrFloors(camera: SKCameraNode)
    {
        if self.position.x + self.size.width < camera.position.x {
            self.position.x += self.size.width * 3;
        }
    }
}
