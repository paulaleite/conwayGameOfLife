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
    var button: UIButton?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Adds the view of the Scene
        guard let sceneView = self.view as? SCNView else { return }
        
        // Adds the Scene
        let scene = GameScene()
        sceneView.scene = scene
        
        // Makes the tap work
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tap(_:)))
        sceneView.addGestureRecognizer(tapGesture)
        
        createPlayButton()
        
    }
    
    func createPlayButton() {
        button = UIButton(type: .system)
        button?.setTitle("Play!", for: .normal)
        button?.setTitleColor(.orange, for: .normal)
        button?.titleLabel?.font = button?.titleLabel?.font.withSize(25)
        button?.addTarget(self, action: #selector(play), for: .touchUpInside)
        
        guard let sceneView = self.view as? SCNView,
            let button = button else { return }
        sceneView.addSubview(button)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: sceneView.centerXAnchor),
            button.bottomAnchor.constraint(equalTo: sceneView.bottomAnchor, constant: -70)
        ])
    }
    
    @objc func play() {
        
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
            
            node.changeColor()
            
        }
    }
    
}
