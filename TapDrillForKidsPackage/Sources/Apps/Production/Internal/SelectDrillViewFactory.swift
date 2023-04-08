//
//  SelectDrill.swift
//  
//
//  Created by 若江照仁 on 2023/03/02.
//

import SwiftUI
import Core
import FeatureSelectLevel
import FeatureSelectDrill
import RepositoryImpl

enum SelectDrillViewFactoryImpl: SelectDrillViewFactoryProtocol {
    typealias ViewModel = SelectDrillViewModelImpl
    
    @MainActor
    static func DrillLevelSelectorView<T: DrillLevelSelector>(_ selector: T) -> AnyView {
        typealias useCase = SelectLevelInteractor<RepositoryImpl>
        typealias viewModel = SelectLevelViewModelImpl<T, useCase>
        return SelectLevelView<SelectLevelViewFactoryImpl, viewModel>(
            viewModel: .init()
        ).toAnyView()
    }
}
