//
//  GameViewController.swift
//  GameOfLife
//
//  Created by Paula Leite on 31/10/19.
//  Copyright © 2019 Paula Leite. All rights reserved.
//

import UIKit
import SceneKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Adds the view of the Scene
        let sceneView = SCNView(frame: self.view.frame)
        self.view.addSubview(sceneView)
        
        // Adds the Scene
        let scene  = SCNScene()
        sceneView.scene = scene
        
        // Adds camera
        let camera = SCNCamera()
        let cameraNode = SCNNode()
        cameraNode.camera = camera
        cameraNode.position = SCNVector3(x: 5.0, y: 4.0, z: 25.0)
        
        // Adds light
        let light = SCNLight()
        light.type = .omni
        let lightNode = SCNNode()
        lightNode.light = light
        lightNode.position = SCNVector3(x: 5.0, y: 5.0, z: -5.0)
        
        // Adds grid
        let size = 9
        let half = Int(size/2)
        var centerCube = SCNNode()
        
        for i in 0..<size {
            for j in 0..<size {
                let cubeGeometry = SCNBox(width: 1.0, height: 1.0, length: 1.0, chamferRadius: 0.0)
                let cubeNode = SCNNode(geometry: cubeGeometry)
                cubeNode.position = SCNVector3(1.15 * Float(i), 1.15 * Float(j), 0)
                
                scene.rootNode.addChildNode(cubeNode)
                
                if i == half && j == half {
                    centerCube = cubeNode
                }
                
                let constraint = SCNLookAtConstraint(target: centerCube)
                constraint.isGimbalLockEnabled = true
                cameraNode.constraints = [constraint]
            }
        }
        
        scene.rootNode.addChildNode(cameraNode)
        scene.rootNode.addChildNode(lightNode)
    }
    
}
