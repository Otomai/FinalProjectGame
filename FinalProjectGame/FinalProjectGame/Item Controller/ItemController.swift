//
//  ItemController.swift
//  FinalProjectGame
//
//  Created by Tristan Garzon on 2018-04-24.
//  Copyright © 2018 Tristan Garzon. All rights reserved.
//

import SpriteKit

class ItemController  {
    
    private var minY = CGFloat(-263), maxY = CGFloat(263);
    
    func spawnItems(camera: SKCameraNode) -> SKSpriteNode {
        let item: SKSpriteNode?;
        
        if Int(randomBetweenNumbers(firstNum: 0, secondNum: 10)) >= 6
        {
            item = SKSpriteNode(imageNamed: "poop");
            item?.name = "poop";
            item?.setScale(0.2);
            item?.physicsBody = SKPhysicsBody(rectangleOf: item!.size);
        } else {
            item = SKSpriteNode(imageNamed: "cd2");
            item?.name = "cd2";
            item?.setScale(0.2)
            item?.physicsBody = SKPhysicsBody(circleOfRadius: item!.size.height / 2);
            
        }
        item!.physicsBody?.affectedByGravity = false;
        item?.physicsBody?.categoryBitMask = ColliderType.BEAM_AND_CD;
        
        item?.zPosition = 4;
        item?.anchorPoint = CGPoint(x: 0.5, y: 0.5);
        
        item?.position.x = camera.position.x + 900;
        item?.position.y = randomBetweenNumbers(firstNum: minY, secondNum: maxY);
        
        return item!;
    }
    
    func randomBetweenNumbers(firstNum: CGFloat, secondNum: CGFloat) -> CGFloat {
        
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs (firstNum - secondNum) + min(firstNum, secondNum);
    }
    
}
