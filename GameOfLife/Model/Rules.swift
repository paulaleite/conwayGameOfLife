//
//  Rule.swift
//  GameOfLife
//
//  Created by Paula Leite on 01/11/19.
//  Copyright © 2019 Paula Leite. All rights reserved.
//

import Foundation

class OverPopulationRule {
    static func isExecuted(for cube: Cube, basedOn aliveNeighbours: [Cube]) -> Bool {
        if cube.state == .alive {
            if aliveNeighbours.count > 4 {
                return true // .dead
            }
        }
        
        return false // .alive
    }
}

class SolitudeRule {
    static func isExecuted(for cube: Cube, basedOn aliveNeighbours: [Cube]) -> Bool {
        if cube.state == .alive {
            if aliveNeighbours.count < 2 {
                return true // .dead
            }
        }
        
        return false // .alive
    }
}

class SurvivesRule {
    static func isExecuted(for cube: Cube, basedOn aliveNeighbours: [Cube]) -> Bool {
        if cube.state == .alive {
            if aliveNeighbours.count >= 2 && aliveNeighbours.count <= 3 {
                return true // .alive
            }
        }
        
        return false // .dead
    }
}

class BornRule {
    static func isExecuted(for cube: Cube, basedOn aliveNeighbours: [Cube]) -> Bool {
        if cube.state == .dead {
            if aliveNeighbours.count == 4 {
                return true // .alive
            }
        }
        
        return false // .dead
    }
}
