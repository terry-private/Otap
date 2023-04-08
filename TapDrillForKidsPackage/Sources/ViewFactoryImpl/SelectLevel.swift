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
import RepositoryImpl
import Utility
import SwiftUI

public enum SelectLevelViewFactoryImpl: SelectLevelViewFactoryProtocol {
    
    @MainActor
    public static func drillView<D: CoreDrill>(generator: DrillGenerator<D>, lastRecord: DrillRecord, dismiss: @escaping () -> Void) -> AnyView {
        typealias UseCase = DrillInteractor<D, RepositoryImpl>
        typealias ViewModel = DrillViewModelImpl<D, SoundEffectInteractor<RepositoryImpl>, UseCase>
        return DrillView<ViewModel, RepositoryImpl>(
            viewModel: .init(
                useCase: .init(generator: generator, lastRecord: lastRecord),
                dismiss: dismiss)
        ).toAnyView()
    }
    
    public static func practiceModeView<D: CoreDrill>(_ generator: DrillGenerator<D>) -> AnyView {
        PrepareModeView<D, SoundEffectInteractor<RepositoryImpl>>()
            .toAnyView()
    }
}
