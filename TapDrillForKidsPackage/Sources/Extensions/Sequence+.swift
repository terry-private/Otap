//
//  Sequence+.swift
//  
//
//  Created by 若江照仁 on 2023/03/01.
//

import Foundation

public extension Sequence {
    func toArray() -> Array<Element> {
        Array(self)
    }
    
    func divide(into columnsCount: Int) -> Array<Array<Element>> {
        let array = toArray()
        let fraction = array.count%columnsCount
        let rowsCount = array.count/columnsCount + (fraction > 0 ? 1 : 0)
        return (0..<rowsCount).map { rowIndex in
            let startIndex = rowIndex*columnsCount
            let rowCount = Swift.min(array.count - startIndex, columnsCount)
            return array[startIndex..<startIndex + rowCount].map { $0 }
        }
    }
}
