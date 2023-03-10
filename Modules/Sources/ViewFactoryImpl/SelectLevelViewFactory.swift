//
//  SelectLevelViewFactory.swift
//  
//
//  Created by 若江照仁 on 2023/02/24.
//

import Foundation
import Core
import FeatureDrill
import FeaturePracticeMode
import FeatureSelectLevel
import Repository
import Utility
import SwiftUI

public enum SelectLevelViewFactoryImpl: SelectLevelViewFactoryProtocol {
    
    @MainActor
    public static func drillView<Q: CoreDrill>(generator: DrillGenerator<Q>, lastRecord: DrillRecord, dismiss: @escaping () -> Void) -> AnyView {
        DrillView<DrillViewModelImpl<Q, SoundEffectInteractor, DrillInteractor<Q, RepositoryImpl>>>(
            viewModel: .init(
                useCase: .init(generator: generator, lastRecord: lastRecord),
                dismiss: dismiss)
        ).toAnyView()
    }
    
    public static func practiceModeView<Q: CoreDrill>(_ generator: DrillGenerator<Q>) -> AnyView {
        PracticeModeView<Q, SoundEffectInteractor>()
            .toAnyView()
    }
}
