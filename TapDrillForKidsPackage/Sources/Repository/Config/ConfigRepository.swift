//
//  File.swift
//  
//
//  Created by 若江照仁 on 2023/04/01.
//

import Foundation
import Core

public protocol ConfigRepository {
    static var drillPanelLeadingPadding: CGFloat { get set }
    static var drillPanelTrailingPadding: CGFloat { get set }
}
