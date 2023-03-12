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

public enum SelectLevelViewFactoryImpl: SelectLevelViewFactoryProtocol {
    
    @MainActor
    public static func drillView<D: CoreDrill>(generator: DrillGenerator<D>, lastRecord: DrillRecord, dismiss: @escaping () -> Void) -> AnyView {
        DrillView<DrillViewModelImpl<D, SoundEffectInteractor, DrillInteractor<D, RepositoryImpl>>>(
            viewModel: .init(
                useCase: .init(generator: generator, lastRecord: lastRecord),
                dismiss: dismiss)
        ).toAnyView()
    }
    
    public static func practiceModeView<D: CoreDrill>(_ generator: DrillGenerator<D>) -> AnyView {
        PrepareModeView<D, SoundEffectInteractor>()
            .toAnyView()
    }
}
