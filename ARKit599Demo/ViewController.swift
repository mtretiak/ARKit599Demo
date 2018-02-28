//
//  ViewController.swift
//  ARKit599Demo
//
//  Created by Michael Tretiak on 2018-02-28.
//  Copyright © 2018 Michael Tretiak. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    var nodeModel: SCNNode!
    let nodeName = "merc" //make sure this matches the asset name
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Create a new scene
        //blank
        let scene = SCNScene()
        
        // Set the scene to the view
        sceneView.scene = scene
        
        let modelScene = SCNScene(named: "art.scnassets/merc.dae")!
        
        nodeModel = modelScene.rootNode.childNode(withName: nodeName, recursively: true)
        
        
        sceneView.debugOptions = ARSCNDebugOptions.showWorldOrigin
        sceneView.debugOptions = ARSCNDebugOptions.showFeaturePoints
        
        sceneView.antialiasingMode = .multisampling4X
        
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        // this tracks device orientation and position for us relative to realworld objects
        // this is what helps the device understand where an object is placed and can move around it.
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    // MARK: - ARSCNViewDelegate
    

    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        if !anchor.isKind(of: ARPlaneAnchor.self) {
            DispatchQueue.main.async {
                let modelClone = self.nodeModel.clone()
                modelClone.position = SCNVector3Zero
                
                // Add model as a child of the node
                node.addChildNode(modelClone)
            }
        }
    }

    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        
        
        
//        let location = touches.first!.location(in: sceneView)
//
//        var hitTestOptions = [SCNHitTestOption: Any]()
//        hitTestOptions[SCNHitTestOption.boundingBoxOnly] = true
//
//        let hitResults: [SCNHitTestResult]  = sceneView.hitTest(location, options: hitTestOptions)
//
//        if let hit = hitResults.first {
//            if let node = getParent(hit.node) {
//                node.removeFromParentNode()
//                return
//            }
//        }
//
//
//        let hitResultsFeaturePoints: [ARHitTestResult] = sceneView.hitTest(location, types: .featurePoint)
//
//        if let hit = hitResultsFeaturePoints.first{
//
//            // Get a transformation matrix with the euler angle of the camera
//            let rotate = simd_float4x4(SCNMatrix4MakeRotation(sceneView.session.currentFrame!.camera.eulerAngles.y, 0, 1, 0))
//
//            // Combine both transformation matrices
//            let finalTransform = simd_mul(hit.worldTransform, rotate)
//
//
//            sceneView.session.add(anchor: ARAnchor(transform: finalTransform))
//        }
        
    }
    
    
    func getParent(_ nodeFound: SCNNode?) -> SCNNode? {
        if let node = nodeFound {
            if node.name == nodeName {
                return node
            } else if let parent = node.parent {
                return getParent(parent)
            }
        }
        return nil
    }

    
    
    
    
}
