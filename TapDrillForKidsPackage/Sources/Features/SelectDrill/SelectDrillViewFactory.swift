//
//  SelectDrillViewFactory.swift
//  
//
//  Created by 若江照仁 on 2023/03/02.
//

import SwiftUI
import Core

public protocol SelectDrillViewFactoryProtocol {
    @MainActor
    static func DrillLevelSelectorView<T: DrillLevelSelector>(_ selector: T) -> AnyView
}

#if DEBUG
enum SelectDrillViewFactoryDummy: SelectDrillViewFactoryProtocol {
    @MainActor
    static func DrillLevelSelectorView<T>(_ selector: T) -> AnyView where T : DrillLevelSelector {
        AnyView(T.previewDrill.answer.viewType.view())
    }
}
#endif
