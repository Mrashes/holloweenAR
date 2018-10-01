//
//  ViewController.swift
//  #pumpkins
//
//  Created by Max Rashes on 9/30/18.
//  Copyright © 2018 Rashco. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    var sceneController = HoverScene()
    
    var didInitializeScene: Bool = false
    
    
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        if let camera = sceneView.session.currentFrame?.camera {
            didInitializeScene = true
            let transform = camera.transform
            let position = SCNVector3(transform.columns.3.x, transform.columns.3.y, transform.columns.3.z)
            sceneController.makeUpdateCameraPos(towards: position)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Create a new scene
        if let scene = sceneController.scene {
            sceneView.scene = scene
        }
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.didTapScreen))
        self.view.addGestureRecognizer(tapRecognizer)
//        let scene = SCNScene(named: "art.scnassets/halloween.scn")!
        
//        // Set the scene to the view
//        sceneView.scene = scene
        
        
//        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.didTapScreen))
//        self.view.addGestureRecognizer(tapRecognizer)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    @objc func didTapScreen(recognizer: UITapGestureRecognizer) {
        if didInitializeScene, let camera = sceneView.session.currentFrame?.camera {
            let tapLocation = recognizer.location(in: sceneView)
            let hitTestResults = sceneView.hitTest(tapLocation)
            if let node = hitTestResults.first?.node,
                let scene = sceneController.scene,
                let pumpkin = node.topmost(until: scene.rootNode) as? Pumpkin {
                pumpkin.animate()
            }
            else {
                var translation = matrix_identity_float4x4
                translation.columns.3.z = -5.0
                let transform = camera.transform * translation
                let position = SCNVector3(transform.columns.3.x, transform.columns.3.y, transform.columns.3.z)
                sceneController.addPumpkin(position: position)
            }
        }
    }
    
    //        if didInitializeScene, let camera = sceneView.session.currentFrame?.camera {
    //            let tapLocation = recognizer.location(in: sceneView)
    //            let hitTestResults = sceneView.hitTest(tapLocation)
    //            print("intialized")
    //            if let node = hitTestResults.first?.node, let scene = sceneController.scene, let pumpkin = node.topmost(until: scene.rootNode) as? Pumpkin {
    //                sceneController.addAnimation(node: pumpkin)
    //            }
    //            else {
    //                var translation = matrix_identity_float4x4
    //                translation.columns.3.z = -5.0
    //                let transform = camera.transform * translation
    //                let position = SCNVector3(transform.columns.3.x, transform.columns.3.y, transform.columns.3.z)
    //                sceneController.addPumpkin(position: position)
    //            }
    
    // MARK: - ARSCNViewDelegate
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }

}
