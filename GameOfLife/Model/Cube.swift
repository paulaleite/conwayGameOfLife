//
//  Cell.swift
//  GameOfLife
//
//  Created by Paula Leite on 31/10/19.
//  Copyright © 2019 Paula Leite. All rights reserved.
//

import SceneKit

enum CubeState {
    case alive
    case dead
}

// Creation of the base shape of the Game of Life
class Cube: SCNNode {
    var state: CubeState = .dead
    
    override init() {
        super.init()
        self.geometry = SCNBox(width: 1.0, height: 1.0, length: 1.0, chamferRadius: 0.0)
        self.geometry?.firstMaterial?.emission.contents = UIColor.gray
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func changeColor() {
        if state == .alive {
            state = .dead
            geometry?.firstMaterial?.emission.contents = UIColor.gray
        } else {
            state = .alive
            geometry?.firstMaterial?.emission.contents = UIColor.orange
        }
    }
}
