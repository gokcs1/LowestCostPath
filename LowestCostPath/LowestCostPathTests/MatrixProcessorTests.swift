//
//  MatrixProcessorTests.swift
//  LowestCostPathTests
//
//  Created by GCS on 12/19/17.
//  Copyright © 2017 NA. All rights reserved.
//

import XCTest
@testable import LowestCostPath

class MatrixProcessorTests: XCTestCase {

    // init Tests
    func testInitMatrixProcessorWithFailure ()
    {
        do
        {
            _ = try MatrixProcessor(with: "")
        }
        catch let error {
            let customError = error as! CustomError
            XCTAssertTrue(customError == CustomError.noData)
        }
    }
    
    func testInitMatrixProcessorWithSuccess ()
    {
        let input = "3 4 1 2 8 6\n6 1 8 2 7 4\n5 9 3 9 9 5\n8 4 1 3 2 6\n3 7 2 8 6 4"
        do
        {
            _ = try MatrixProcessor(with: input)
        }
        catch let error {
            XCTAssertNil(error)
        }
    }
    
    // ProcessColumn Tests
    
    func testProcessColumnForFirstColumn () // first column should be always left as it is without being changed
    {
        let input = "3 4 1 2 8 6\n6 1 8 2 7 4\n5 9 3 9 9 5\n8 4 1 3 2 6\n3 7 2 8 6 4"
        do
        {
            let processor = try MatrixProcessor(with: input)
            let result = processor.processColumn(column: 0)
            XCTAssertTrue(result.0 == [3, 6, 5, 8, 3]) // first column should be returned as it is
            XCTAssertTrue(result.proceedNext)
        }
        catch let error {
            XCTAssertNil(error)
        }
    }
    
    func testProcessColumnAboveThreshold ()
    {
        let input = "69 10 19 10 19\n51 23 20 19 12\n60 12 20 11 10"
        do
        {
            let processor = try MatrixProcessor(with: input)
            let result = processor.processColumn(column: 0)
            XCTAssertTrue(result.0 == [69,51,60]) // first column should be returned as it is
            XCTAssertFalse(result.proceedNext) // minimum is above thresholds so algorithm will not proceed
        }
        catch let error {
            XCTAssertNil(error)
        }
    }
    func testProcessColumnForSecondColumn ()
    {
        let input = "3 4 1 2 8 6\n6 1 8 2 7 4\n5 9 3 9 9 5\n8 4 1 3 2 6\n3 7 2 8 6 4"
        do
        {
            let processor = try MatrixProcessor(with: input)
            let result = processor.processColumn(column: 1)
            XCTAssertTrue(result.0 == [7, 4, 14, 7, 10]) // first column should be returned as it is
            XCTAssertTrue(result.proceedNext) // it should move on to the next column
        }
        catch let error {
            XCTAssertNil(error)
        }
    }
    
    
    // CellIndiciesForColumn Tests
    func testCellIndiciesForColumnSample ()
    {
        let input = "3 4 1 2 8 6\n6 1 8 2 7 4\n5 9 3 9 9 5\n8 4 1 3 2 6\n3 7 2 8 6 4"
        do
        {
            let processor = try MatrixProcessor(with: input)
            let result = processor.cellIndiciesForColumn(column: 0)
            XCTAssertTrue(result.count == 5) // should be the same as column count
            XCTAssertTrue(result[0] == (0,0))
            XCTAssertTrue(result[1] == (1,0))
            XCTAssertTrue(result[2] == (2,0))
            XCTAssertTrue(result[3] == (3,0))
            XCTAssertTrue(result[4] == (4,0))       }
        catch let error {
            XCTAssertNil(error)
        }
    }
    
    // ProcessedTillEnd Tests
    
    func testProcessedTillEndTrueScenario ()
    {
        let input = "3 4 1 2 8 6\n6 1 8 2 7 4\n5 9 3 9 9 5\n8 4 1 3 2 6\n3 7 2 8 6 4"
        do
        {
            let processor = try MatrixProcessor(with: input)
            _ = processor.processColumn(column: 0)
            _ = processor.processColumn(column: 1)
            _ = processor.processColumn(column: 2)
            _ = processor.processColumn(column: 3)
            _ = processor.processColumn(column: 4)
            _ = processor.processColumn(column: 5)
            XCTAssertTrue(processor.processedTillEnd())
        }
        catch let error {
            XCTAssertNil(error)
        }
    }
    
    func testProcessedTillEndFalseScenario ()
    {
        let input = "3 4 1 2 8 6\n6 1 8 2 7 4\n5 9 3 9 9 5\n8 4 1 3 2 6\n3 7 2 8 6 4"
        do
        {
            let processor = try MatrixProcessor(with: input)
            _ = processor.processColumn(column: 0)
            XCTAssertFalse(processor.processedTillEnd())
        }
        catch let error {
            XCTAssertNil(error)
        }
    }
    
    // MinimumOfCells Tests
    func testMiniumumOfCellsForSample1 () // 5*6 matrix
    {
        let input = "3 4 1 2 8 6\n6 1 8 2 7 4\n5 9 3 9 9 5\n8 4 1 3 2 6\n3 7 2 8 6 4"
        do
        {
            let processor = try MatrixProcessor(with: input)
            let result = processor.miniumumOfCellsFor(cellindices: [(1,1),(2,1),(3,1)])
            XCTAssertTrue(result.index! == (1,1))
            XCTAssertTrue(result.value! == 1)
        }
        catch let error {
            XCTAssertNil(error)
        }
    }
    
    func testMiniumumOfCellsForSample2 () // 3*5 matrix
    {
        let input = "19 10 19 10 19\n21 23 20 19 12\n20 12 20 11 10"
        do
        {
            let processor = try MatrixProcessor(with: input)
            let result = processor.miniumumOfCellsFor(cellindices: [(1,1),(2,1),(3,1)])
            XCTAssertTrue(result.index! == (2,1))
            XCTAssertTrue(result.value! == 12)
        }
        catch let error {
            XCTAssertNil(error)
        }
    }
    
    // TraceShortestPath Tests
    
    func testTraceShortestPathForSample1()
    {
        let input = "19 10 19 10 19\n21 23 20 19 12\n20 12 20 11 10"
        do
        {
            let processor = try MatrixProcessor(with: input)
            _ = processor.processColumn(column: 0)
            _ = processor.processColumn(column: 1)
            _ = processor.processColumn(column: 2)
            let result = processor.traceShortestPath()!
            XCTAssertFalse(result.pathExists)
            XCTAssertTrue(result.cost == 48)
            XCTAssertTrue(result.path[0] == (0,0))
            XCTAssertTrue(result.path[1] == (0,1))
            XCTAssertTrue(result.path[2] == (0,2))

        }
        catch let error {
            XCTAssertNil(error)
        }
    }
    
    func testShortestPathForSample2()
    {
        let input = "3 4 1 2 8 6\n6 1 8 2 7 4\n5 9 3 9 9 5\n8 4 1 3 2 6\n3 7 2 1 2 3"
        do
        {
            let processor = try MatrixProcessor(with: input)
            _ = processor.processColumn(column: 0)
            _ = processor.processColumn(column: 1)
            _ = processor.processColumn(column: 2)
            _ = processor.processColumn(column: 3)
            _ = processor.processColumn(column: 4)
            _ = processor.processColumn(column: 5)

            let result = processor.traceShortestPath()!
            XCTAssertTrue(result.pathExists)
            XCTAssertTrue(result.cost == 11)
            XCTAssertTrue(result.path[0] == (0,0))
            XCTAssertTrue(result.path[1] == (1,1))
            XCTAssertTrue(result.path[2] == (0,2))
            XCTAssertTrue(result.path[3] == (4,3))
            XCTAssertTrue(result.path[4] == (3,4))
            XCTAssertTrue(result.path[5] == (4,5))

        }
        catch let error {
            XCTAssertNil(error)
        }
    }
    
    // MinimumCostForColumn Tests
    
    func testMinimumCostForColumnForSample1 () // 3*5 matrix
    {
        let input = "19 10 19 10 19\n21 23 20 19 12\n20 12 20 11 10"
        do
        {
            let processor = try MatrixProcessor(with: input)
            let result = processor.minimumCostForColumn(column: 1)
            XCTAssertTrue(result.index! == (0,1))
            XCTAssertTrue(result.value! == 10)
        }
        catch let error {
            XCTAssertNil(error)
        }
    }
    
    func testMinimumCostForColumnForSample2 () // 5*6 matrix
    {
        let input = "3 4 1 2 8 6\n6 1 8 2 7 4\n5 9 3 9 9 5\n8 4 1 3 2 6\n3 7 2 1 2 3"
        do
        {
            let processor = try MatrixProcessor(with: input)
            let result = processor.minimumCostForColumn(column: 4)
            XCTAssertTrue(result.index! == (3,4))
            XCTAssertTrue(result.value! == 2)
        }
        catch let error {
            XCTAssertNil(error)
        }
    }
    
    
    // ProcessMatrix Tests
    func testProcessMatrixForThreshold ()
    {
        let input = "51 51 51\n51 51 51\n51 51 51 \n51 51 5"
        do
        {
            let processor = try MatrixProcessor(with: input)
            let result = processor.processMatrix()!
            XCTAssertTrue(result.path.isEmpty)
            XCTAssertTrue(result.cost == 0)
            XCTAssertTrue(result.pathCompleted == false)
        }
        catch let error {
            XCTAssertNil(error)
        }
    }
    
    func testProcessMatrixForProperScenario ()  // 5*6 matrix
    {
       let input = "3 4 1 2 8 6\n6 1 8 2 7 4\n5 9 3 9 9 5\n8 4 1 3 2 6\n3 7 2 1 2 3"
        let expectedPath = [1,2,1,5,4,5]
        do
        {
            let processor = try MatrixProcessor(with: input)
            let result = processor.processMatrix()!
            XCTAssertTrue(result.path == expectedPath)
            XCTAssertTrue(result.cost == 11)
            XCTAssertTrue(result.pathCompleted)
        }
        catch let error {
            XCTAssertNil(error)
        }
    }
}
