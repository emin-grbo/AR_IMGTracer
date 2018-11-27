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
    configuration.maximumNumberOfTrackedImages = 1
    
    sceneView.session.run(configuration)
  }
  
  
  
  func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
    
    let node = SCNNode()

    if let imageAnchor = anchor as? ARImageAnchor {
      let planeScene = SCNScene(named: "ARassets.scnassets/plane.scn")
      let planeNode = planeScene?.rootNode.childNodes.first!
      
      planeNode?.position = SCNVector3Zero
      planeNode?.position.y = 0.15
      
      node.addChildNode(planeNode!)
    }
    
    return node
  }
  
  


}

