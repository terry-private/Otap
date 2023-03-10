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
    static func drillView<Q: CoreDrill>(generator: DrillGenerator<Q>, lastRecord: DrillRecord, dismiss: @escaping () -> Void) -> AnyView
    
    static func practiceModeView<Q: CoreDrill>(_ generator: DrillGenerator<Q>) -> AnyView
}

#if DEBUG
public enum SelectLevelViewFactoryDummy: SelectLevelViewFactoryProtocol {
    @MainActor
    public static func drillView<Q: CoreDrill>(generator: DrillGenerator<Q>, lastRecord: DrillRecord, dismiss: @escaping () -> Void) -> AnyView {
        EmptyView().toAnyView()
    }
    
    public static func practiceModeView<Q: CoreDrill>(_ generator: DrillGenerator<Q>) -> AnyView {
        EmptyView().toAnyView()
    }
}
#endif
