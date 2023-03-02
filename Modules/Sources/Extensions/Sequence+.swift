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
}
