//
//  GameScene.swift
//  GameOfLife
//
//  Created by Paula Leite on 01/11/19.
//  Copyright © 2019 Paula Leite. All rights reserved.
//

import SceneKit

class GameScene: SCNScene {
    // Initializing the Element Matrix, empty
    var elements = [[Element]]()
    var newGeneration = [[ElementState]]()
    var height: Float = 0.0
    var currentGeneration = 0
    
    override init() {
        super.init()
        addCamera()
        addLight()
        addGrid()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addCamera() {
        // Adds camera
        let camera = SCNCamera()
        let cameraNode = SCNNode()
        cameraNode.camera = camera
        cameraNode.name = "camera"
        cameraNode.position = SCNVector3(x: 5.0, y: 4.0, z: 25.0)
        rootNode.addChildNode(cameraNode)
    }
    
    func addLight() {
        // Adds light
        let light = SCNLight()
        light.type = .omni
        let lightNode = SCNNode()
        lightNode.light = light
        lightNode.position = SCNVector3(x: 5.0, y: 5.0, z: -5.0)
        rootNode.addChildNode(lightNode)
    }
    
    func setConstraintCamera(_ centerElement: Element) {
        let constraint = SCNLookAtConstraint(target: centerElement)
        constraint.isGimbalLockEnabled = true
        
        guard let cameraNode = rootNode.childNode(withName: "camera", recursively: true) else { return }
        cameraNode.constraints = [constraint]
    }
    
    func addGrid() {
        // Adds grid
        let size = 13
        let half = Int(size/2)
        var centerElement = Element()

        elements = []
        for i in 0 ..< size {
            elements.append([])
            for j in 0..<size {
                let element = Element()
                
                element.position = SCNVector3(1.15 * Float(i), 1.15 * Float(j), 1.15 * height)
                
                elements[i].append(element)
                
                if currentGeneration == 0 {
                    self.rootNode.addChildNode(element)
                } else {
                    element.changeState(to: newGeneration[i][j], basedOn: height)
                    if element.state == .alive {
                        self.rootNode.addChildNode(element)
                    }
                }
                
                if i == half && j == half {
                    centerElement = element
                }
                
                setConstraintCamera(centerElement)
            }
        }
    }
    
    func startNewGeneration() {
        newGeneration = [] // Makes sure that it always starts empty
        for i in 0 ..< elements.count {
            newGeneration.append([])
            for j in 0 ..< elements[i].count {
                newGeneration[i].append(elements[i][j].getChangedState(basedOn: elements))
            }
        }
        
        height += 1
        currentGeneration += 1
        addGrid()
    }
    
    func updateStates() {
        for i in 0 ..< elements.count {
            for j in 0 ..< elements.count {
                elements[i][j].changeState(to: newGeneration[i][j], basedOn: height)
            }
        }
    }
    
}



