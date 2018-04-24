//
//  Player.swift
//  FinalProjectGame
//
//  Created by Tristan Garzon on 2018-04-24.
//  Copyright © 2018 Tristan Garzon. All rights reserved.
//

import SpriteKit

struct ColliderType {
    static let PLAYER: UInt32 = 0;
    static let GROUND: UInt32 = 1;
    static let BEAM_AND_CD: UInt32 = 2;

    
}

class Player: SKSpriteNode {
    
    private var playerAnimation = [SKTexture]();
    private var animatePlayerAction = SKAction();
    
    func initializePlayer() {
        name = "Player";
        
        for i in 1...3 {
            let name = "Player \(i)";
            playerAnimation.append(SKTexture(imageNamed: name));
        }
        
        animatePlayerAction = SKAction.animate(with: playerAnimation, timePerFrame: 0.5, resize: true, restore: false);
        self.run(SKAction.repeatForever(animatePlayerAction));
        
        physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.size.width, height: self.size.height));
        physicsBody?.affectedByGravity = true;
        physicsBody?.allowsRotation = false;
        physicsBody?.restitution = 0;
        physicsBody?.categoryBitMask = ColliderType.PLAYER;
        physicsBody?.collisionBitMask = ColliderType.GROUND;
        physicsBody?.contactTestBitMask = ColliderType.BEAM_AND_CD;
        
    }
    
    func move(){
        self.position.x += 10;
    }
    
    func reversePlayer() {
        self.yScale *= -1;
    }
}
