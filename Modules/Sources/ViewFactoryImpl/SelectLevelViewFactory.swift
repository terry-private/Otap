//
//  SelectLevelViewFactory.swift
//  
//
//  Created by 若江照仁 on 2023/02/24.
//

import Foundation
import Core
import FeaturePracticeMode
import FeatureSelectLevel
import FeatureVoiceQuiz
import Repository
import Utility
import SwiftUI

public enum SelectLevelViewFactoryImpl: SelectLevelViewFactoryProtocol {
    
    @MainActor
    public static func voiceQuizView<Q: VoiceQuiz>(generator: VoiceQuizGenerator<Q>, lastRecord: GameRecord, dismiss: @escaping () -> Void) -> AnyView {
        VoiceQuizView<VoiceQuizViewModelImpl<Q, SoundEffectInteractor, VoiceQuizInteractor<Q, RepositoryImpl>>>(
            viewModel: .init(
                useCase: .init(generator: generator, lastRecord: lastRecord),
                dismiss: dismiss)
        ).toAnyView()
    }
    
    public static func practiceModeView<Q: VoiceQuiz>(_ generator: VoiceQuizGenerator<Q>) -> AnyView {
        PracticeModeView<Q, SoundEffectInteractor>()
            .toAnyView()
    }
}
