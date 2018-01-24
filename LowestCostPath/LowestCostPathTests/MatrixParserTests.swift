//
//  MatrixParserTests.swift
//  LowestCostPathTests
//
//  Created by GCS on 12/19/17.
//  Copyright © 2017 NA. All rights reserved.
//

import XCTest
@testable import LowestCostPath

class MatrixParserTests: XCTestCase {
    
    func testParseForEmptyData ()
    {
        let input = ""
        let parseResult = MatrixParser.parse(input)
        if case Result.failure(CustomError.noData) = parseResult
        {
            XCTAssert(true)
        }
        else
        {
            XCTAssert(false)
        }
    }
    
    func testParseForDataWithEmptyLastLine ()
    {
        let input = "3 4 1 2 8 6\n6 1 8 2 7 4\n5 9 3 9 9 5\n8 4 1 3 2 6\n3 7 2 8 6 4\n"
        let parseResult = MatrixParser.parse(input)
        if case Result.success( _) = parseResult
        {
            XCTAssert(true)
        }
        else
        {
            XCTAssert(false)
        }
    }
    func testParseForUnEvenColumnsSample1 ()
    {
        let input = "3 4 1 2 8 6\n6 1 8 2 7 4\n5 9 3 9 9 5\n8 4 1 3 2 6\n3 7 2 8 6\n"
        let parseResult = MatrixParser.parse(input)
        if case Result.failure(CustomError.incorrectFormat) = parseResult
        {
            XCTAssert(true)
        }
        else
        {
            XCTAssert(false)
        }
    }
    func testParseForUnEvenColumnsSample2 ()
    {
        let input = "3 1 2 8 6\n1 8 2 7 4\n5 9 2 3 9 9 5\n8 4 1 3 2 6\n3 7 2 8 6\n"
        let parseResult = MatrixParser.parse(input)
        if case Result.failure(CustomError.incorrectFormat) = parseResult
        {
            XCTAssert(true)
        }
        else
        {
            XCTAssert(false)
        }
    }
    
    func testParseForNonIntegerInputsSample1 ()
    {
        let input = "3 4 1 2 8 6\n6 1 8 2 7 4\n5 9 3 9 9 5\n8 4 1 c 2 6\n3 7 2 8 6 a"
        let parseResult = MatrixParser.parse(input)
        if case Result.failure(CustomError.incorrectFormat) = parseResult
        {
            XCTAssert(true)
        }
        else
        {
            XCTAssert(false)
        }
    }
    
    func testParseForNonIntegerInputsSample2 ()
    {
        let input = "e 4 1 2 8 6\n6 1 8 2 7 4\n5 9 3 9 9 5\n8 4 1 c 2 6"
        let parseResult = MatrixParser.parse(input)
        if case Result.failure(CustomError.incorrectFormat) = parseResult
        {
            XCTAssert(true)
        }
        else
        {
            XCTAssert(false)
        }
    }
    
    func testParseForNegativeInputs ()
    {
        let input = "69 -10 19 10 19\n51 23 20 19 -12\n60 12 20 11 10"
        let parseResult = MatrixParser.parse(input)
        if case Result.success( _) = parseResult
        {
            XCTAssert(true)
        }
        else
        {
            XCTAssert(false)
        }
    }
    
    func testParseForValidInput ()
    {
        let input = "19 10 19 10 19\n21 23 20 19 12\n20 12 20 11 10"
        let parseResult = MatrixParser.parse(input)
        if case Result.success( _) = parseResult
        {
            XCTAssert(true)
        }
        else
        {
            XCTAssert(false)
        }
    }
    
    
}
