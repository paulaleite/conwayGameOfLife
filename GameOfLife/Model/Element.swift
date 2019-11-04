//
//  Cell.swift
//  GameOfLife
//
//  Created by Paula Leite on 31/10/19.
//  Copyright © 2019 Paula Leite. All rights reserved.
//

import SceneKit

enum ElementState {
    case alive
    case dead
}

// Creation of the base shape of the Game of Life
class Element: SCNNode {
    var state: ElementState = .dead
    
    override init() {
        super.init()
        self.geometry = SCNSphere(radius: 0.5)
//        self.geometry = SCNBox(width: 1.0, height: 1.0, length: 1.0, chamferRadius: 0.0)
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
    
    // Addapts to the rules
    func getChangedState(basedOn elements: [[Element]]) -> ElementState {
        let neighbours = getNeighbours(with: elements)
        // Everything that is .alive will be returned
        let aliveNeighbours = neighbours.filter { (element) -> Bool in
            element.state == .alive
        }
        
        if OverPopulationRule.isExecuted(for: self, basedOn: aliveNeighbours)
            || SolitudeRule.isExecuted(for: self, basedOn: aliveNeighbours) {
            return .dead
        }
        
        if SurvivesRule.isExecuted(for: self, basedOn: aliveNeighbours)
            || BornRule.isExecuted(for: self, basedOn: aliveNeighbours) {
            return .alive
        }
        
        return state
    }
    
    // Animates the matrix
    func animate(toZ z: CGFloat, withColor color: UIColor) {
        geometry?.firstMaterial?.emission.contents = color
        self.runAction(SCNAction.move(to: SCNVector3(CGFloat(self.position.x), CGFloat(self.position.y), z), duration: 0.5))
    }
    
    func getNeighbours(with elements: [[Element]]) -> [Element] {
        let index = findIndex(with: elements)
        let i = index[0]
        let j = index[1]
        if i == -1 || j == -1 {
            return []
        }
        
        var neighbours = [Element]()
        // Top
        if j - 1 >= 0 {
            neighbours.append(elements[i][j - 1])
        }
        
        // Bottom
        if j + 1 < elements.count {
            neighbours.append(elements[i][j + 1])
        }
        
        // Right
        if i + 1 < elements.count {
            neighbours.append(elements[i + 1][j])
        }
        
        // Left
        if i - 1 >= 0 {
            neighbours.append(elements[i - 1][j])
        }
        
        // Top Left
        if i - 1 >= 0 && j - 1 >= 0 {
            neighbours.append(elements[i - 1][j - 1])
        }
        
        // Top Right
        if i - 1 >= 0 && j + 1 < elements.count {
            neighbours.append(elements[i - 1][j + 1])
        }
        
        // Bottom Left
        if i + 1 < elements.count && j - 1 >= 0 {
            neighbours.append(elements[i + 1][j - 1])
        }
        
        // Bottom Right
        if i + 1 < elements.count && j + 1 < elements.count {
            neighbours.append(elements[i + 1][j + 1])
        }
        
        return neighbours
    }
    
    // Finds the index of the element that is required
    func findIndex(with elements: [[Element]]) -> [Int] {
        for i in 0 ..< elements.count {
            for j in 0 ..< elements[i].count {
                if self == elements[i][j] {
                    return [i, j]
                }
            }
        }
        
        return [-1, -1]
    }
    
    func changeState(to state: ElementState, basedOn height: Float) {
        if state == .alive {
            if height.truncatingRemainder(dividingBy: 2.0) == 0 {
                animate(toZ: CGFloat(height + 1), withColor: .orange)
            } else {
                animate(toZ: CGFloat(height + 1), withColor: .systemTeal)
            }

        } else {
            animate(toZ: CGFloat(height), withColor: .gray)
        }
        self.state = state
    }
    
}
