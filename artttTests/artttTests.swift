//
//  artttTests.swift
//  artttTests
//
//  Created by Shao-Ping Lee on 10/4/17.
//  Copyright © 2017 Simon Lee. All rights reserved.
//

import XCTest
@testable import arttt

class artttTests: XCTestCase {
    let grid = Grid(playerMarks: ["O", "X"])
    
    func testDirectWin() {
        XCTAssertFalse(grid.placeMark(mark: "O", x: 0, y: 0, z: 0))
        XCTAssertFalse(grid.placeMark(mark: "O", x: 0, y: 1, z: 0))
        XCTAssertFalse(grid.placeMark(mark: "O", x: 0, y: 2, z: 0))
        
        // Step finishes a line
        XCTAssertTrue(grid.placeMark(mark: "O", x: 0, y: 3, z: 0))
    }
    
    func testUnfinished() {
        XCTAssertFalse(grid.placeMark(mark: "O", x: 0, y: 0, z: 0))
        XCTAssertFalse(grid.placeMark(mark: "O", x: 0, y: 1, z: 0))
        XCTAssertFalse(grid.placeMark(mark: "O", x: 0, y: 2, z: 0))
    }
    
    func testBlocked() {
        XCTAssertFalse(grid.placeMark(mark: "O", x: 0, y: 0, z: 0))
        XCTAssertFalse(grid.placeMark(mark: "O", x: 0, y: 1, z: 0))
        XCTAssertFalse(grid.placeMark(mark: "X", x: 0, y: 2, z: 0))
        XCTAssertFalse(grid.placeMark(mark: "O", x: 0, y: 3, z: 0))
    }
    
    func testDiagonal() {
        XCTAssertFalse(grid.placeMark(mark: "O", x: 0, y: 0, z: 0))
        XCTAssertFalse(grid.placeMark(mark: "O", x: 1, y: 1, z: 1))
        XCTAssertFalse(grid.placeMark(mark: "O", x: 2, y: 2, z: 2))
        
        // Step finishes a line
        XCTAssertTrue(grid.placeMark(mark: "O", x: 3, y: 3, z: 3))
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
            grid.placeMark(mark: "O", x: 0, y: 1, z: 1)
        }
    }
    
}
