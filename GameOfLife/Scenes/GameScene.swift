//
//  GameScene.swift
//  GameOfLife
//
//  Created by Paula Leite on 01/11/19.
//  Copyright © 2019 Paula Leite. All rights reserved.
//

import SceneKit

class GameScene: SCNScene {
    // Initializing the Cube Matrix, empty
    var cubes = [[Cube]]()
    var newGeneration = [[CubeState]]()
    
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
    
    func setConstraintCamera(_ centerCube: Cube) {
        let constraint = SCNLookAtConstraint(target: centerCube)
        constraint.isGimbalLockEnabled = true
        
        guard let cameraNode = rootNode.childNode(withName: "camera", recursively: true) else { return }
        cameraNode.constraints = [constraint]
    }
    
    func addGrid() {
        // Adds grid
        let size = 13
        let half = Int(size/2)
        var centerCube = Cube()

        for i in 0..<size {
            cubes.append([])
            for j in 0..<size {
                let cube = Cube()
                
                cube.position = SCNVector3(1.15 * Float(i), 1.15 * Float(j), 0)
                
                rootNode.addChildNode(cube)
                cubes[i].append(cube)
                
                if i == half && j == half {
                    centerCube = cube
                }
                
                setConstraintCamera(centerCube)
            }
        }
    }
    
    func startNewGeneration() {
        newGeneration = [] // Makes sure that it always starts empty
        for i in 0 ..< cubes.count {
            newGeneration.append([])
            for j in 0 ..< cubes[i].count {
                newGeneration[i].append(cubes[i][j].getChangedState(basedOn: cubes))
            }
        }
        
        updateStates()
    }
    
    func updateStates() {
        for i in 0 ..< cubes.count {
            for j in 0 ..< cubes.count {
                cubes[i][j].changeState(to: newGeneration[i][j])
            }
        }
    }
    
}



