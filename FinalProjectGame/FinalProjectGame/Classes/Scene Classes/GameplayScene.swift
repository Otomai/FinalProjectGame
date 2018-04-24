//
//  GameplayScene.swift
//  FinalProjectGame
//
//  Created by Tristan Garzon on 2018-04-23.
//  Copyright © 2018 Tristan Garzon. All rights reserved.
//

import SpriteKit

class GameplayScene: SKScene {
    
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
    
    private var itemController = ItemController();
    
    override func didMove(to view: SKView) {
        initializeGame();
    }
    
    override func update(_ currentTime: TimeInterval) {
    manageCamera();
    manageBGsandGrounds();
        player?.move();
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        reverseGravity();
    }
    
        //Initialize Game Func
        private func initializeGame() {
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
            
            Timer.scheduledTimer(timeInterval: TimeInterval(itemController.randomBetweenNumbers(firstNum: 1, secondNum: 3)), target: self, selector: #selector (GameplayScene.spawnItems), userInfo: nil, repeats: true);

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
    
}
