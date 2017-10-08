//
//  Grid.swift
//  arttt
//
//  Created by Shao-Ping Lee on 10/5/17.
//  Copyright © 2017 Simon Lee. All rights reserved.
//

import SceneKit

class Grid: SCNNode {
    let cell: Float = 0.05
    var gridPosition: SCNVector3
    init(atPosition position: SCNVector3, width: Int, height: Int, depth: Int) {
        gridPosition = position
        super.init()
        
        let box = SCNBox(width: CGFloat(cell * Float(width)), height: CGFloat(cell * Float(height)), length: CGFloat(cell * Float(depth)), chamferRadius: 0)
        let boxMaterial = SCNMaterial()
        boxMaterial.diffuse.contents = UIColor(white: 1.0, alpha: 0.0)
        box.firstMaterial = boxMaterial
        let boxNode = SCNNode(geometry: box)
        boxNode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
        boxNode.physicsBody?.categoryBitMask = 1 << 1
        boxNode.physicsBody?.mass = 2.0
        boxNode.position = position
        
        for i in 1...width + 1 {
            for z in 0...depth {
                addLine(to: boxNode, 0.001, cell * Float(height), 0.001, Float(i), 0, Float(z))
            }
        }
        for i in 0...height {
            for z in 0...depth {
                addLine(to: boxNode, cell * Float(width), 0.001, 0.001, 1, Float(i), Float(z))
            }
        }
        for i in 1...width + 1 {
            for j in 0...height {
                addLine(to: boxNode, 0.001, 0.001, cell * 4, Float(i), Float(j), 4)
            }
        }
        
        self.addChildNode(boxNode)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) not implemented")
    }

    func addLine(to node: SCNNode, _ w: Float, _ h: Float, _ l: Float, _ x: Float, _ y: Float, _ z: Float) {
        let line = SCNBox(width: CGFloat(w), height: CGFloat(h), length: CGFloat(l), chamferRadius: 0)
        let matrix = SCNMatrix4Translate(translate(x, y + 1, z + 1), w / 2, h / 2, -l / 2)
        node.addChildNode(createNode(line, matrix, UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.4)))
    }
    
    func translate(_ x: Float, _ y: Float, _ z: Float = 0) -> SCNMatrix4 {
        return SCNMatrix4MakeTranslation((x - 3) * cell, (y - 3) * cell , (z - 3) * cell)
    }
    
    func createNode(_ geometry: SCNGeometry, _ matrix: SCNMatrix4, _ color: UIColor) -> SCNNode {
        let material = SCNMaterial()
        material.diffuse.contents = color
        // use the same material for all geometry elements
        geometry.firstMaterial = material
        let node = SCNNode(geometry: geometry)
        node.transform = matrix
        return node
    }
}
