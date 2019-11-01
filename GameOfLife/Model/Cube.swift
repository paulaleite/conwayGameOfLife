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
            animate(toZ: 0.0, withColor: .gray)
        } else {
            state = .alive
            animate(toZ: 1.0, withColor: .orange)
        }
    }
    
    func changeState(basedOn aliveNeighbours: [Cube]) {
        if OverPopulationRule.isExecuted(for: self, basedOn: aliveNeighbours)
            || SolitudeRule.isExecuted(for: self, basedOn: aliveNeighbours) {
            self.state = .dead
            animate(toZ: 0.0, withColor: .gray)
        }
        
        if SurvivesRule.isExecuted(for: self, basedOn: aliveNeighbours)
            || BornRule.isExecuted(for: self, basedOn: aliveNeighbours) {
            self.state = .alive
            animate(toZ: 1.0, withColor: .orange)
        }
    }
    
    func animate(toZ z: CGFloat, withColor color: UIColor) {
        geometry?.firstMaterial?.emission.contents = color
        self.runAction(SCNAction.move(to: SCNVector3(CGFloat(self.position.x), CGFloat(self.position.y), z), duration: 0.5))
    }
    
}
