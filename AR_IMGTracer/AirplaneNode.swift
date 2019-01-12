//
//  AirplaneNode.swift
//  AR_IMGTracer
//
//  Created by Emin Roblack on 12/15/18.
//  Copyright © 2018 emiN Roblack. All rights reserved.
//

import Foundation
import ARKit

class AirplaneNode: SCNNode {
  
  private var music: SCNAction?
  private var audio = SCNNode()

  override init() {
    
    super.init()

    if let planeScene = SCNScene(named: "ARassets.scnassets/plane.scn") {
      
      let planeNode = planeScene.rootNode.childNodes.first!
      animate(node: planeNode, scene: planeScene)
      planeNode.position.y = 0.1
      self.addChildNode(planeNode)
      
    }
    
    self.music = SCNAction.playAudio(SCNAudioSource(named: "flight.mp3")!, waitForCompletion: false)
    
    guard let music = self.music else { return }
    self.runAction(music)
    
  }
  
  override var isHidden: Bool {
    
    didSet {
      guard isHidden != oldValue else { return }
      
      if isHidden {
        self.audio.removeAllActions()
      } else {
      guard let music = music else {return}
      self.audio.runAction(music)
      }
      
    }
  }
  
  
  func animate(node: SCNNode, scene: SCNScene) {

    // Rotation Animation---------------------------------------------------
    node.rotation.x = -0.3
    let rotate = SCNAction.rotateBy(x: 0.6, y: 0.1, z: 0, duration: 1.3)
    rotate.timingMode = .easeInEaseOut
    let rotateBack = rotate.reversed()
    let rotation = SCNAction.sequence([rotate, rotateBack])
    let rotationFinal = SCNAction.repeatForever(rotation)
    //-------------------------------------------------------------
    
    // Move Animation---------------------------------------------
    let move = SCNAction.moveBy(x: 0, y: 0, z: -0.05, duration: 1.6)
    move.timingMode = .easeInEaseOut
    let moveBack = move.reversed()
    let moveFinal = SCNAction.sequence([move,moveBack])
    let moveRepeat = SCNAction.repeatForever(moveFinal)
    //-------------------------------------------------------------
    
    // Tip Animation -------------------------------------------
        if let tip = scene.rootNode.childNode(withName: "prop_tip01", recursively: true) {
        let propelerRotation = SCNAction.rotateBy(x: 0, y: 5, z: 0, duration: 0.1)
        let propelerFinal = SCNAction.repeatForever(propelerRotation)
        tip.runAction(propelerFinal)
        }
    //-------------------------------------------------------------
    
    let animations = SCNAction.group([rotationFinal, moveRepeat])
    
    node.runAction(animations)
    
  }
  
  
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
