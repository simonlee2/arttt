//
//  PrimitiveScene.swift
//  SceneKit-Tutorial
//
//  Created by Shao-Ping Lee on 7/22/17.
//  Copyright © 2017 Simon Lee. All rights reserved.
//

import UIKit
import SceneKit

class PrimitiveScene: SCNScene {
    let cell: Float = 0.1
    override init() {
        super.init()
        
//        grid()
//        self.rootNode.addChildNode(createWellFrame(4, 4, 4))
//        blocks(0, 0, 0)
//        blocks(1, 1, 1)
//        blocks(2, 2, 2)
//        blocks(3, 3, 3)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func blocks(_ x: Int, _ y: Int, _ z: Int) {
        let block = SCNBox(width: CGFloat(cell), height: CGFloat(cell), length: CGFloat(cell), chamferRadius: 0)
        let node = SCNNode(geometry: block)
        node.transform = translate(Float(x) + 1, Float(y), Float(z))
        self.rootNode.addChildNode(node)
    }
    
    func createWellFrame(_ width: Int, _ height: Int, _ depth: Int) -> SCNNode {
        let node = SCNNode()
        for i in 1...width + 1 {
            for z in 0...depth {
                addLine(to: node, 0.001, cell * Float(height), 0.001, Float(i), 0, Float(z))
            }
        }
        for i in 0...height {
            for z in 0...depth {
                addLine(to: node, cell * Float(width), 0.001, 0.001, 1, Float(i), Float(z))
            }
        }
        for i in 1...width + 1 {
            for j in 0...height {
                addLine(to: node, 0.001, 0.001, cell * 4, Float(i), Float(j), 4)
            }
        }
        return node
    }
    
    func addLine(to node: SCNNode, _ w: Float, _ h: Float, _ l: Float, _ x: Float, _ y: Float, _ z: Float) {
        let line = SCNBox(width: CGFloat(w), height: CGFloat(h), length: CGFloat(l), chamferRadius: 0)
        let matrix = SCNMatrix4Translate(translate(x - 0.5, y - 0.5, z - 0.5), w / 2, h / 2, -l / 2)
        node.addChildNode(createNode(line, matrix, UIColor(red: 255.0, green: 0.0, blue: 0.0, alpha: 1.0)))
    }
    
    func translate(_ x: Float, _ y: Float, _ z: Float = 0) -> SCNMatrix4 {
        return SCNMatrix4MakeTranslation(0.0 + x * cell, 0.0 + y * cell, -2.0 + z * cell)
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
