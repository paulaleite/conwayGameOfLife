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
        
    }
    
}
