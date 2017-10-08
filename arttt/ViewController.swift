//
//  ViewController.swift
//  arttt
//
//  Created by Shao-Ping Lee on 10/4/17.
//  Copyright © 2017 Simon Lee. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController {

    @IBOutlet var sceneView: ARSCNView!
    var planes: [UUID: Plane] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        sceneView.debugOptions = [ARSCNDebugOptions.showWorldOrigin, ARSCNDebugOptions.showFeaturePoints]
        
        // Set up lighting
        sceneView.autoenablesDefaultLighting = true
        
        
        // Create a new scene
        let scene = PrimitiveScene()
        
        // Set the scene to the view
        sceneView.scene = scene
        
        // Bottom
        let bottomPlane = SCNBox(width: CGFloat(1000), height: CGFloat(0.5), length: CGFloat(1000), chamferRadius: 0)
        let bottomMaterial = SCNMaterial()
        bottomMaterial.diffuse.contents = UIColor(white: 1.0, alpha: 0.0)
        bottomPlane.materials = [bottomMaterial]
        let bottomNode = SCNNode(geometry: bottomPlane)
        bottomNode.position = SCNVector3(x: 0, y: -10, z:0)
        bottomNode.physicsBody = SCNPhysicsBody(type: .kinematic, shape: nil)
        bottomNode.physicsBody?.categoryBitMask = 1 << 0
        bottomNode.physicsBody?.contactTestBitMask = 1 << 1
        
        sceneView.scene.rootNode.addChildNode(bottomNode)
        sceneView.scene.physicsWorld.contactDelegate = self
        
        // Gesture
        registerRecognizers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal

        // Run the view's session
        sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    func registerRecognizers() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        tapGestureRecognizer.numberOfTapsRequired = 1
        sceneView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func handleTap(_ recognizer: UITapGestureRecognizer) {
        let tap = recognizer.location(in: self.sceneView)
        let result = sceneView.hitTest(tap, types: .existingPlaneUsingExtent)
        
        guard let hitResult = result.first else { return }
        
        insertGeometry(hitResult: hitResult)
    }
    
    func insertGeometry(hitResult: ARHitTestResult) {
        let insertionYOffset: Float = 0.5
        let hitTransform = SCNMatrix4(hitResult.worldTransform)
        let position = SCNVector3(
            hitTransform.m41,
            hitTransform.m42 + insertionYOffset,
            hitTransform.m43
        )
        
        let boxNode = Grid(atPosition: position, width: 4, height: 4, depth: 4)
        
        sceneView.scene.rootNode.addChildNode(boxNode)
    }
}

extension ViewController: SCNPhysicsContactDelegate {
    func physicsWorld(_ world: SCNPhysicsWorld, didBegin contact: SCNPhysicsContact) {
//        print("contact")
    }
}

extension ViewController: ARSCNViewDelegate {
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard let planeAnchor = anchor as? ARPlaneAnchor else { return }
        
        let plane = Plane(withPlaneAnchor: planeAnchor)
        planes[planeAnchor.identifier] = plane
        node.addChildNode(plane)
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        guard let planeAnchor = anchor as? ARPlaneAnchor,
            let plane = planes[planeAnchor.identifier]
            else { return }
        
        plane.update(withPlaneAnchor: planeAnchor)
    }
}

extension ViewController: ARSessionObserver {
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
