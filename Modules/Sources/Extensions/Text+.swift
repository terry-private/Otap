//
//  File.swift
//  
//
//  Created by 若江照仁 on 2023/02/27.
//

import Foundation
import SwiftUI

public extension Text {
    func foregroundLinearGradient(
        colors: [Color],
        startPoint: UnitPoint,
        endPoint: UnitPoint) -> some View
    {
        self.overlay {
            LinearGradient(
                colors: colors,
                startPoint: startPoint,
                endPoint: endPoint
            )
            .mask(
                self
            )
        }
    }
}
