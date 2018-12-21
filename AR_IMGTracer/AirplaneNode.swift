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
      self.addChildNode(planeNode)
    }
    
    self.music = SCNAction.playAudio(SCNAudioSource(named: "flight.mp3")!, waitForCompletion: false)
    
    guard let music = self.music else { return }
    self.runAction(music)
    
    self.position = SCNVector3Zero
    self.position.y = 0.15
    
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
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
