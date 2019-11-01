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
        guard let sceneView = self.view as? SCNView else { return }
        
        // Adds the Scene
        let scene  = GameScene()
        sceneView.scene = scene
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tap(_:)))
        sceneView.addGestureRecognizer(tapGesture)
        
    }
    
    @objc func tap(_ gestureRecognizer: UIGestureRecognizer)  {
        // Adds the view of the Scene
        guard let sceneView = self.view as? SCNView else { return }
        
        // Finds the cube that was touched
        let point = gestureRecognizer.location(in: sceneView)
        let hitResults = sceneView.hitTest(point, options: [:])
        
        if hitResults.count > 0  {
            let objectClicked = hitResults[0]
            guard let node = objectClicked.node as? Cube else { return }
            
        }
    }
    
}
