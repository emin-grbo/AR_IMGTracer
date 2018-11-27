//
//  ViewController.swift
//  AR_IMGTracer
//
//  Created by Emin Roblack on 11/26/18.
//  Copyright © 2018 emiN Roblack. All rights reserved.
//

import UIKit
import ARKit
import SceneKit

class ViewController: UIViewController, ARSCNViewDelegate {

  @IBOutlet weak var sceneView: ARSCNView!
  let configuration = ARImageTrackingConfiguration()
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    sceneView.delegate = self
    
    let scene = SCNScene(named: "ARassets.scnassets/GameScene.scn")!
    sceneView.scene = scene
    
    sceneView.autoenablesDefaultLighting = true
  }
  
  
  
  override func viewWillAppear(_ animated: Bool) {
    
    guard  let trackedImages = ARReferenceImage.referenceImages(inGroupNamed: "Photos", bundle: Bundle.main) else {
      return print("No images avaialble")
    }
    
    configuration.trackingImages = trackedImages
    configuration.maximumNumberOfTrackedImages = 2
    
    sceneView.session.run(configuration)
  }
  
  
  
  func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
    
    let node = SCNNode()

    if let _ = anchor as? ARImageAnchor {
      if let planeScene = SCNScene(named: "ARassets.scnassets/plane.scn") {
        let planeNode = planeScene.rootNode.childNodes.first!
        
        planeNode.position = SCNVector3Zero
        planeNode.position.y = 0.15
        
        if let tip = planeScene.rootNode.childNode(withName: "prop_tip01", recursively: true) {
          let propelerRotation = SCNAction.rotateBy(x: 0, y: 5, z: 0, duration: 0.1)
          let propelerFinal = SCNAction.repeatForever(propelerRotation)
          tip.runAction(propelerFinal)
        }
        
        animate(node: planeNode, scene: planeScene)
        
        node.addChildNode(planeNode)
      }
    }
      

    return node
  }
  
  func animate(node: SCNNode, scene: SCNScene) {
    
    // Rotation Animation---------------------------------------------------
    node.rotation.x = -0.3
    let rotate = SCNAction.rotateBy(x: 0.6, y: 0.1, z: 0, duration: 1.5)
    rotate.timingMode = .easeInEaseOut
    let rotateBack = rotate.reversed()
    let rotation = SCNAction.sequence([rotate, rotateBack])
    let rotationFinal = SCNAction.repeatForever(rotation)
    //-------------------------------------------------------------
    
    // Move Animation---------------------------------------------
    let move = SCNAction.moveBy(x: 0, y: 0, z: 0.05, duration: 2)
    move.timingMode = .easeInEaseOut
    let moveBack = move.reversed()
    let moveFinal = SCNAction.sequence([move,moveBack])
    let moveRepeat = SCNAction.repeatForever(moveFinal)
    //-------------------------------------------------------------
    
    // Tip Animation -------------------------------------------
//    if let tip = scene.rootNode.childNode(withName: "prop_tip01", recursively: true) {
//    let propelerRotation = SCNAction.rotateBy(x: 0, y: 1, z: 0, duration: 0.1)
//    let propelerFinal = SCNAction.repeatForever(propelerRotation)
//    tip.runAction(propelerFinal)
//    }
    //-------------------------------------------------------------
    
    let animations = SCNAction.group([rotationFinal, moveRepeat])
    
    node.runAction(animations)
  }
  
  


}

