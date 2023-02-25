//
//  SelectLevelViewFactory.swift
//  
//
//  Created by 若江照仁 on 2023/02/24.
//

import Foundation
import Core
import Feature
import Repository
import Utility

public enum SelectLevelViewFactoryImpl<LevelSelector: VoiceQuizLevelSelector>: SelectLevelViewFactoryProtocol {
    public typealias Quiz = LevelSelector.Quiz
    public typealias SelectLevelViewModel = SelectLevelViewModelImpl<LevelSelector, SelectLevelInteractor<RepositoryImpl>>
    public typealias VoiceQuizViewModel = VoiceQuizViewModelImpl<Quiz, SoundEffectInteractor, VoiceQuizInteractor<Quiz, RepositoryImpl>>
    
    @MainActor
    public static func voiceQuizView(generator: VoiceQuizGenerator<Quiz>, lastRecord: GameRecord, dismiss: @escaping () -> Void) -> VoiceQuizView<VoiceQuizViewModel> {
        .init(viewModel: .init(useCase: .init(generator: generator, lastRecord: lastRecord), dismiss: dismiss))
    }
}
