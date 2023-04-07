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
import Repository

public enum SelectDrillViewFactoryImpl: SelectDrillViewFactoryProtocol {
    public typealias ViewModel = SelectDrillViewModelImpl
    
    @MainActor
    public static func DrillLevelSelectorView<T: DrillLevelSelector>(_ selector: T) -> AnyView {
        typealias useCase = SelectLevelInteractor<RepositoryImpl>
        typealias viewModel = SelectLevelViewModelImpl<T, useCase>
        return SelectLevelView<SelectLevelViewFactoryImpl, viewModel>(
            viewModel: .init()
        ).toAnyView()
    }
}
