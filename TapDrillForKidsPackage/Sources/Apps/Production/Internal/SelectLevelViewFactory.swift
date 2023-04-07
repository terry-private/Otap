//
//  SelectLevel.swift
//  
//
//  Created by 若江照仁 on 2023/02/24.
//

import Foundation
import Core
import FeatureDrill
import FeaturePrepareMode
import FeatureSelectLevel
import Repository
import Utility
import SwiftUI

enum SelectLevelViewFactoryImpl: SelectLevelViewFactoryProtocol {
    
    @MainActor
    static func drillView<D: CoreDrill>(generator: DrillGenerator<D>, lastRecord: DrillRecord, dismiss: @escaping () -> Void) -> AnyView {
        typealias UseCase = DrillInteractor<D, RepositoryImpl>
        typealias ViewModel = DrillViewModelImpl<D, SoundEffectInteractor, UseCase>
        return DrillView<ViewModel, RepositoryImpl>(
            viewModel: .init(
                useCase: .init(generator: generator, lastRecord: lastRecord),
                dismiss: dismiss)
        ).toAnyView()
    }
    
    static func practiceModeView<D: CoreDrill>(_ generator: DrillGenerator<D>) -> AnyView {
        PrepareModeView<D, SoundEffectInteractor>()
            .toAnyView()
    }
}
