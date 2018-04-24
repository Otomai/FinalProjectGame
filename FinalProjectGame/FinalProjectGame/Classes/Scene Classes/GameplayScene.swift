//
//  GameplayScene.swift
//  FinalProjectGame
//
//  Created by Tristan Garzon on 2018-04-23.
//  Copyright © 2018 Tristan Garzon. All rights reserved.
//

import SpriteKit

class GameplayScene: SKScene, SKPhysicsContactDelegate {
    
    private var bg1: BGClass?;
    private var bg2: BGClass?;
    private var bg3: BGClass?;
    
    private var ground1: GroundClass?;
    private var ground2: GroundClass?;
    private var ground3: GroundClass?;
    
    private var floor1: GroundClass?;
    private var floor2: GroundClass?;
    private var floor3: GroundClass?;

    private var player: Player?;
    
    private var maincamera : SKCameraNode?;
    
    private var scoreLabel: SKLabelNode?;
    private var score = 0;
    
    private var itemController = ItemController();
    
    override func didMove(to view: SKView) {
        initializeGame();
    }
    
    //Update Func
    override func update(_ currentTime: TimeInterval) {
    manageCamera();
    manageBGsandGrounds();
        player?.move();
        moveEnemy();
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        reverseGravity();
    }
    
    //Collision Detection func
    func didBegin(_ contact: SKPhysicsContact) {
        var firstBody = SKPhysicsBody();
        var secondBody = SKPhysicsBody();
        
        if contact.bodyA.node?.name == "Player" {
            firstBody = contact.bodyA;
            secondBody = contact.bodyB;
        } else {
            firstBody = contact.bodyB;
            secondBody = contact.bodyA;
        }
        
        if firstBody.node?.name == "Player" && secondBody.node?.name == "cd2" {
            score += 1;
            scoreLabel?.text = String(score);
            secondBody.node?.removeFromParent();
        }
        if firstBody.node?.name == "Player" && secondBody.node?.name == "poop" {
            firstBody.node?.removeFromParent();
            secondBody.node?.removeFromParent()
            
            Timer.scheduledTimer(timeInterval: TimeInterval(2), target: self, selector: #selector(GameplayScene.restartGame), userInfo: nil, repeats: false);
            
        }
    }
    
        //Initialize Game Func
        private func initializeGame() {
            
            physicsWorld.contactDelegate = self;
            
            maincamera = childNode(withName: "maincamera") as?
                SKCameraNode!;
            
        //Backgrounds
            bg1 = childNode (withName: "BG1") as? BGClass!;
            bg2 = childNode (withName: "BG2") as? BGClass!;
            bg3 = childNode (withName: "BG3") as? BGClass!;
            
            ground1 = childNode(withName: "ground1") as? GroundClass!;
            ground2 = childNode(withName: "ground2") as? GroundClass!;
            ground3 = childNode(withName: "ground3") as? GroundClass!;
            
            ground1?.initializeGroundAndFloor();
            ground2?.initializeGroundAndFloor();
            ground3?.initializeGroundAndFloor();

            
            floor1 = childNode(withName: "floor1") as? GroundClass!;
            floor2 = childNode(withName: "floor2") as? GroundClass!;
            floor3 = childNode(withName: "floor3") as? GroundClass!;
            
            floor1?.initializeGroundAndFloor();
            floor2?.initializeGroundAndFloor();
            floor3?.initializeGroundAndFloor();

            
            player = childNode(withName: "Player") as? Player!;
            player?.initializePlayer();
            
            scoreLabel = maincamera!.childNode(withName: "ScoreLabel") as? SKLabelNode!;
            
            scoreLabel?.text = "0";
            
            Timer.scheduledTimer(timeInterval: TimeInterval(itemController.randomBetweenNumbers(firstNum: 1, secondNum: 3)), target: self, selector: #selector (GameplayScene.spawnItems), userInfo: nil, repeats: true);
            
               Timer.scheduledTimer(timeInterval: TimeInterval(7), target: self, selector: #selector (GameplayScene.removeItems), userInfo: nil, repeats: true);

        }
    
        //Manage Camera Func
    private func manageCamera() {
        self.maincamera?.position.x += 10;
    }
    
    
    private func manageBGsandGrounds() {
        bg1?.moveBG(camera: maincamera!);
        bg2?.moveBG(camera: maincamera!);
        bg3?.moveBG(camera: maincamera!);
        
        ground1?.moveGroundsOrFloors(camera: maincamera!);
        ground2?.moveGroundsOrFloors(camera: maincamera!);
        ground3?.moveGroundsOrFloors(camera: maincamera!);
        
        floor1?.moveGroundsOrFloors(camera: maincamera!);
        floor2?.moveGroundsOrFloors(camera: maincamera!);
        floor3?.moveGroundsOrFloors(camera: maincamera!);
        
        

    }
        
    private func reverseGravity(){
        //Everytime the screen is touched gravity (9.8) is reversed due to * it by -1
        physicsWorld.gravity.dy *= -1;
        player?.reversePlayer();
    }
    
    @objc func spawnItems() {
        self.scene?.addChild(itemController.spawnItems(camera: maincamera!));
    }
    
    @objc func restartGame(){
        if let scene = GameplayScene(fileNamed: "GameplayScene") {
            // Set the scale mode to scale to fit the window
            scene.scaleMode = .aspectFill
            
            // Present the scene
            view!.presentScene(scene, transition: SKTransition.doorsOpenVertical(withDuration: TimeInterval(1)));
        }
        
    }
    
    
    private func moveEnemy() {
        enumerateChildNodes(withName: "poop", using: ({
            (node, error) in
            node.position.x -= 5;
        }))
    }
    
    @objc func removeItems() {
        for child in children {
            if child.name == "cd2" || child.name == "poop" {
                if child.position.x < self.maincamera!.position.x - self.scene!.frame.width / 2 {
                    child.removeFromParent();
                }
            }
        }
    }
    
}
