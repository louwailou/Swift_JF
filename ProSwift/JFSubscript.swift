//
//  JFSubscribe.swift
//  ProSwift
//
//  Created by Sun on 15/11/26.
//  Copyright © 2015年 Sun. All rights reserved.
//

import Foundation
struct TimesTable {
    let multiplier: Int
    subscript(index: Int) -> Int {
        set(newValue){
            
        }
        get{
         return multiplier * index
        }
       
    }
}
//let threeTimesTable = TimesTable(multiplier: 3)
//print("six times three is \(threeTimesTable[6])")
// 输出 "six times three is 18"


struct Matrix {
    let rows: Int, columns: Int
    var grid: [Double]
    init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        grid = Array(count: rows * columns, repeatedValue: 0.0)
    }
    func indexIsValidForRow(row: Int, column: Int) -> Bool {
        return row >= 0 && row < rows && column >= 0 && column < columns
    }
    subscript(row: Int, column: Int) -> Double {
        get {
            assert(indexIsValidForRow(row, column: column), "Index out of range")
            return grid[(row * columns) + column]
        }
        set {
            assert(indexIsValidForRow(row, column: column), "Index out of range")
            grid[(row * columns) + column] = newValue
        }
    }
}