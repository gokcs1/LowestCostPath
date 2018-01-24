//
//  MatrixParser.swift
//  LowestCostPath
//
//  Created by GCS on 12/19/17.
//  Copyright © 2017 NA. All rights reserved.
//

import Foundation

public enum Result {
    case success(Any?)
    case failure(Error)
}

//CustomError
public enum CustomError: LocalizedError {
    case valid
    case incorrectFormat
    case noData
    case unknown

    //Localized description
    public var errorDescription: String? {
        switch self {
        case .valid:
            return "Valid matrix"
        case .incorrectFormat:
            return "Invalid matrix"
        case .noData:
            return "No input"
        case .unknown:
            return "Unkown error"
        }
    }
}

public class MatrixParser {
    
    static func parse(_ input:String) -> Result {
        
        var inputMatrix = [[Int]]()
        let rows = input.components(separatedBy: "\n")
        var columnCount = 0
        var rowCount = 0
        
        // Loop through the rows delimited by (\n) new line character
        for row in rows {
            let trimmedRow = row.trimmingCharacters(in: .whitespaces)
            
            // No Input Check
            if(rowCount == 0 && trimmedRow.isEmpty){
                return Result.failure(CustomError.noData)
            }
            
            rowCount = rowCount + 1
            // handling user inserting an empty row at the end of the matrix
            if(rowCount == rows.count && trimmedRow.isEmpty){
                return Result.success(inputMatrix)
            }
            
            // Parse  row for Columns delimited by space (" ")
            let columns = trimmedRow.components(separatedBy:.whitespaces)
            let currentRowColumnCount = columns.count;
            
            // Check for uneven columns except the first row
            if (columnCount > 0 && currentRowColumnCount > 0 && currentRowColumnCount != columnCount) {
                return Result.failure(CustomError.incorrectFormat)
            }
            
            columnCount = currentRowColumnCount;
            
            // Proceed only if we have columns to process
            if columns.count > 0 {
                var columnMatrix = [Int]()
                for column in columns {
                    // Check for non-numeric characters
                    if let convertedInt = Int(column) {
                        // Group all the columns together
                        columnMatrix.append(convertedInt)
                    } else {
                        // non integer values
                        return Result.failure(CustomError.incorrectFormat)
                    }
                }
                
                // Add grouped columns for rows
                inputMatrix.append(columnMatrix)
            }
        }
        
        //Validation success
        return Result.success(inputMatrix)
    }
}
