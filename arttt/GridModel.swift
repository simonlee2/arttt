//
//  GridModel.swift
//  arttt
//
//  Created by Shao-Ping Lee on 10/4/17.
//  Copyright © 2017 Simon Lee. All rights reserved.
//

import Foundation

class GridModel {
    internal var grid = [[[String]]](repeating: [[String]](repeating: [String](repeating: "", count: 4), count: 4), count: 4)
    let playerMarks: [String]
    
    init(playerMarks: [String]) {
        self.playerMarks = playerMarks
    }
    
    @discardableResult func placeMark(mark: String, x: Int, y: Int, z: Int) -> Bool {
        self.grid[x][y][z] = mark
        return checkVictory(x: x, y: y, z: z)
    }
    
    func checkVictory(x: Int, y: Int, z: Int) -> Bool {
        guard playerMarks.contains(self.grid[x][y][z]) else { return false }
        
        // check x-axis
        if (0..<4).map({self.grid[$0][y][z]}).allEqual() {
            return true
        }
        
        // check y-axis
        if (0..<4).map({self.grid[x][$0][z]}).allEqual() {
            return true
        }
        
        // check z-axis
        if (0..<4).map({self.grid[x][y][$0]}).allEqual() {
            return true
        }
        
        // check xy-diagonals
        if x == y {
            if (0..<4).map({self.grid[$0][$0][z]}).allEqual() {
                return true
            }
        }
        
        if x + y == 3 {
            if (0..<4).map({self.grid[$0][3 - $0][z]}).allEqual() {
                return true
            }
        }
        
        // check xz-diagonals: 2 diagonals
        if x == z {
            if (0..<4).map({self.grid[$0][y][$0]}).allEqual() {
                return true
            }
        }
        
        if x + z == 3 {
            if (0..<4).map({self.grid[$0][y][3 - $0]}).allEqual() {
                return true
            }
        }
        
        // check yz-diagonals: 2 diagonals
        if y == z {
            if (0..<4).map({self.grid[x][$0][$0]}).allEqual() {
                return true
            }
        }
        
        if y + z == 3 {
            if (0..<4).map({self.grid[x][$0][3 - $0]}).allEqual() {
                return true
            }
        }
        
        // check xyz-diagnal: 4 diagonals here
        if x == y && y == z {
            // 1. 000, 111, 222, 333
            if (0..<4).map({self.grid[$0][$0][$0]}).allEqual() {
                return true
            }
        }
        
        if x == z && x + y == 3 {
            // 2. 030, 121, 212, 303
            if (0..<4).map({self.grid[$0][3 - $0][$0]}).allEqual() {
                return true
            }
        }
        
        if x == y && x + z == 3 {
            // 3. 003, 112, 221, 330
            if (0..<4).map({self.grid[$0][$0][3 - $0]}).allEqual() {
                return true
            }
        }
        
        if y == z && x + y == 3 {
            // 4. 033, 122, 211, 300
            if (0..<4).map({self.grid[$0][3 - $0][3 - $0]}).allEqual() {
                return true
            }
        }
        
        return false
    }
}

extension Array where Element: Equatable {
    func allEqual() -> Bool {
        for item in self {
            if item != self[0] {
                return false
            }
        }
        return true
    }
}
