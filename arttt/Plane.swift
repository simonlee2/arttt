//
//  Plane.swift
//  arttt
//
//  Created by Shao-Ping Lee on 10/8/17.
//  Copyright © 2017 Simon Lee. All rights reserved.
//

import SceneKit
import ARKit

class Plane: SCNNode {
    let height: CGFloat = 0.01
    init(withPlaneAnchor anchor: ARPlaneAnchor) {
        super.init()
        
        let width = CGFloat(anchor.extent.x)
        let length = CGFloat(anchor.extent.z)
        let box = SCNBox(width: width, height: height, length: length, chamferRadius: 0)
        
        let planeNode = SCNNode(geometry: box)
        planeNode.position = SCNVector3(0, -Float(height)/2, 0)
        planeNode.opacity = 0.25
        planeNode.physicsBody = SCNPhysicsBody(type: .kinematic, shape: SCNPhysicsShape(geometry: box, options: nil))
        
        self.addChildNode(planeNode)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) not implemented")
    }
    
    func update(withPlaneAnchor anchor: ARPlaneAnchor) {
        guard let planeNode = childNodes.first,
            let box = planeNode.geometry as? SCNBox
            else { return }
        
        box.width = CGFloat(anchor.extent.x)
        box.length = CGFloat(anchor.extent.z)
        
        position = SCNVector3(anchor.center.x, 0, anchor.center.z)
        
        planeNode.physicsBody = SCNPhysicsBody(type: .kinematic, shape: SCNPhysicsShape(geometry: box, options: nil))
    }
}
