//
//  Matrix.swift
//  LowestCostPath
//
//  Created by GCS on 12/19/17.
//  Copyright © 2017 NA. All rights reserved.
//

import Foundation

// Matrix model
public class Matrix {
    
    public var numberOfColumns = 0
    public var numberOfRows = 0
    public var costValues: [[Int]]?
    
    init(listOfCostValues:[[Int]]) {
        costValues = listOfCostValues
        numberOfRows = costValues!.count
        
        if numberOfRows > 0{
            numberOfColumns = (costValues?.first?.count)!
        }
    }
    
    // Matrix cell index value
    func valueForIndex(index:(row:Int,column:Int)) -> Int? {
        guard index.row > -1 ,index.column > -1, index.row < numberOfRows , index.column < numberOfColumns else {
            return nil
        }
        return self.costValues![index.row][index.column]
    }
    
    //MARK: Cell Edges
    func getNeighbouringCells(For cellIndex:(row:Int,column:Int)) -> ([(Int,Int)]?)  {
        
        guard self.costValues != nil , cellIndex.row > -1 ,cellIndex.column > 0, cellIndex.row < numberOfRows , cellIndex.column < numberOfColumns else {
            return nil
        }
        
        let straight = (cellIndex.row,cellIndex.column-1)
        
        var top = (cellIndex.row - 1,cellIndex.column - 1)
        if cellIndex.row == 0 {
            top = (numberOfRows-1,cellIndex.column - 1)
        }
        
        var bottom = (cellIndex.row+1,cellIndex.column-1)
        if cellIndex.row == numberOfRows - 1 {
            bottom = (0,cellIndex.column - 1)
        }
        
        let adjacentCells = [top,straight,bottom]
        return adjacentCells
    }
    
}
