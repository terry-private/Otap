//
//  SelectLevelViewFactoryProtocol.swift
//  
//
//  Created by 若江照仁 on 2023/02/24.
//

import Foundation
import Core
import SwiftUI

public protocol SelectLevelViewFactoryProtocol {
    @MainActor
    static func drillView<D: CoreDrill>(generator: DrillGenerator<D>, lastRecord: DrillRecord, dismiss: @escaping () -> Void) -> AnyView
    
    static func practiceModeView<D: CoreDrill>(_ generator: DrillGenerator<D>) -> AnyView
}

#if DEBUG
public enum SelectLevelViewFactoryDummy: SelectLevelViewFactoryProtocol {
    @MainActor
    public static func drillView<D: CoreDrill>(generator: DrillGenerator<D>, lastRecord: DrillRecord, dismiss: @escaping () -> Void) -> AnyView {
        EmptyView().toAnyView()
    }
    
    public static func practiceModeView<D: CoreDrill>(_ generator: DrillGenerator<D>) -> AnyView {
        EmptyView().toAnyView()
    }
}
#endif
