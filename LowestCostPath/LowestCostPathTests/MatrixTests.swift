//
//  MatrixTests.swift
//  LowestCostPath
//
//  Created by GCS on 12/19/17.
//  Copyright © 2017 NA. All rights reserved.
//

import XCTest
@testable import LowestCostPath

class MatrixTests: XCTestCase {
   
    func testInitWithEmptyCosts ()
    {
        let matrix = Matrix (listOfCostValues:[[]])
        XCTAssertNotNil(matrix.costValues!)
        XCTAssertTrue(matrix.numberOfRows == 1)
        XCTAssertTrue(matrix.numberOfColumns == 0)
    }
    func testInitWithSample1 ()
    {
        let input = [[3, 4, 1, 2, 8, 6],[6, 1, 8, 2, 7, 4],[5, 9, 3, 9, 9, 5],[8, 4, 1, 3, 2, 6],[3, 7, 2, 8, 6, 4]]
        let matrix = Matrix(listOfCostValues: input)
        XCTAssertNotNil(matrix.costValues!)
        XCTAssertTrue(matrix.numberOfRows == 5)
        XCTAssertTrue(matrix.numberOfColumns == 6)
    }
    
    func testInitWithSample2 ()
    {
        let input = [[3, 4, 1, 2, 8, 6],[6, 1, 8, 2, 7, 4],[5, 9, 3, 9, 9, 5],[8, 4, 1, 3, 2, 6],[3, 7, 2, 1, 2, 3]]
        let matrix = Matrix(listOfCostValues: input)
        XCTAssertNotNil(matrix.costValues!)
        XCTAssertTrue(matrix.numberOfRows == 5)
        XCTAssertTrue(matrix.numberOfColumns == 6)
    }
    
    func testInitWithSample3 ()
    {
        let input = [[19, 10, 19, 10, 19],[21, 23, 20, 19, 12],[20, 12, 20, 11, 10]]
        let matrix = Matrix(listOfCostValues: input)
        XCTAssertNotNil(matrix.costValues!)
        XCTAssertTrue(matrix.numberOfRows == 3)
        XCTAssertTrue(matrix.numberOfColumns == 5)
    }
    
    func testValueForIndexForNegativeRow ()
    {
        let input = [[19, 10, 19, 10, 19],[21, 23, 20, 19, 12],[20, 12, 20, 11, 10]]
        let matrix = Matrix(listOfCostValues: input)
        let value = matrix.valueForIndex(index: (-1,0))
        XCTAssertNil(value)
    }
    
    func testValueForIndexForNegativeColumn ()
    {
        let input = [[19, 10, 19, 10, 19],[21, 23, 20, 19, 12],[20, 12, 20, 11, 10]]
        let matrix = Matrix(listOfCostValues: input)
        let value = matrix.valueForIndex(index: (0,-1))
        XCTAssertNil(value)
    }
    
    func testValueForIndexForIndexOutOfBoundsRow ()
    {
        let input = [[19, 10, 19, 10, 19],[21, 23, 20, 19, 12],[20, 12, 20, 11, 10]]
        let matrix = Matrix(listOfCostValues: input)
        let value = matrix.valueForIndex(index: (3,2))
        XCTAssertNil(value)
    }
    
    func testValueForIndexForIndexOutOfBoundsColumn ()
    {
        let input = [[19, 10, 19, 10, 19],[21, 23, 20, 19, 12],[20, 12, 20, 11, 10]]
        let matrix = Matrix(listOfCostValues: input)
        let value = matrix.valueForIndex(index: (2,5))
        XCTAssertNil(value)
    }
    
    func testValueForIndexForValidIndex ()
    {
        let input = [[19, 10, 19, 10, 19],[21, 23, 20, 19, 12],[20, 12, 20, 11, 10]]
        let matrix = Matrix(listOfCostValues: input)
        let value = matrix.valueForIndex(index: (2,2))
        XCTAssertNotNil(value)
        XCTAssertTrue(value == 20)
    }
    
    func testGetNeighbouringCellsForFirstColumn ()
    {
        let input = [[3, 4, 1, 2, 8, 6],[6, 1, 8, 2, 7, 4],[5, 9, 3, 9, 9, 5],[8, 4, 1, 3, 2, 6],[3, 7, 2, 8, 6, 4]]
        let matrix = Matrix(listOfCostValues: input)
        let value = matrix.getNeighbouringCells(For: (10,0))
        XCTAssertNil(value)
    }
    
    func testGetNeighbouringCellsForNegativeRow ()
    {
        let input = [[3, 4, 1, 2, 8, 6],[6, 1, 8, 2, 7, 4],[5, 9, 3, 9, 9, 5],[8, 4, 1, 3, 2, 6],[3, 7, 2, 8, 6, 4]]
        let matrix = Matrix(listOfCostValues: input)
        let value = matrix.getNeighbouringCells(For: (-1,0))
        XCTAssertNil(value)
    }
    
    func testGetNeighbouringCellsForNegativeColumn ()
    {
        let input = [[3, 4, 1, 2, 8, 6],[6, 1, 8, 2, 7, 4],[5, 9, 3, 9, 9, 5],[8, 4, 1, 3, 2, 6],[3, 7, 2, 8, 6, 4]]
        let matrix = Matrix(listOfCostValues: input)
        let value = matrix.getNeighbouringCells(For: (0,-1))
        XCTAssertNil(value)
    }
    
    func testGetNeighbouringCellsForIndexOutOfBoundsRow ()
    {
        let input = [[3, 4, 1, 2, 8, 6],[6, 1, 8, 2, 7, 4],[5, 9, 3, 9, 9, 5],[8, 4, 1, 3, 2, 6],[3, 7, 2, 8, 6, 4]]
        let matrix = Matrix(listOfCostValues: input)
        let value = matrix.getNeighbouringCells(For: (6,2))
        XCTAssertNil(value)
    }
    
    func testGetNeighbouringCellsForIndexOutOfBoundsColumn ()
    {
        let input = [[3, 4, 1, 2, 8, 6],[6, 1, 8, 2, 7, 4],[5, 9, 3, 9, 9, 5],[8, 4, 1, 3, 2, 6],[3, 7, 2, 8, 6, 4]]
        let matrix = Matrix(listOfCostValues: input)
        let value = matrix.getNeighbouringCells(For: (2,6))
        XCTAssertNil(value)
    }
    
    func testGetNeighbouringCellsForTopRow () // checking the wrapping of the matrix
    {
        let input = [[3, 4, 1, 2, 8, 6],[6, 1, 8, 2, 7, 4],[5, 9, 3, 9, 9, 5],[8, 4, 1, 3, 2, 6],[3, 7, 2, 8, 6, 4]]
        let matrix = Matrix(listOfCostValues: input)
        let value = matrix.getNeighbouringCells(For: (0,1))!
        XCTAssertTrue(value[0] == (4,0)) // top cell with wrapping mechanism
        XCTAssertTrue(value[1] == (0,0)) // straight cell
        XCTAssertTrue(value[2] == (1,0)) // bottom cell
    }
    
    func testGetNeighbouringCellsForBottomRow () // checking the wrapping of the matrix
    {
        let input = [[3, 4, 1, 2, 8, 6],[6, 1, 8, 2, 7, 4],[5, 9, 3, 9, 9, 5],[8, 4, 1, 3, 2, 6],[3, 7, 2, 8, 6, 4]]
        let matrix = Matrix(listOfCostValues: input)
        let value = matrix.getNeighbouringCells(For: (4,1))!
        XCTAssertTrue(value[0] == (3,0)) // top cell
        XCTAssertTrue(value[1] == (4,0)) // straight cell
        XCTAssertTrue(value[2] == (0,0)) // bottom cell with wrapping mechanism
    }
    
    func testGetNeighbouringCellForNormalScenario ()
    {
         let input = [[3, 4, 1, 2, 8, 6],[6, 1, 8, 2, 7, 4],[5, 9, 3, 9, 9, 5],[8, 4, 1, 3, 2, 6],[3, 7, 2, 8, 6, 4]]
        let matrix = Matrix(listOfCostValues: input)
        let value = matrix.getNeighbouringCells(For: (2,2))!
        XCTAssertTrue(value[0] == (1,1)) // top cell
        XCTAssertTrue(value[1] == (2,1)) // straight cell
        XCTAssertTrue(value[2] == (3,1)) // bottom cell
    }
}
