//
//  SelectCategoryViewFactory.swift
//  
//
//  Created by 若江照仁 on 2023/02/24.
//

import Foundation
import Core
import Feature
import Repository
import Utility

public enum SelectCategoryViewFactoryImpl<Category: VoiceQuizCategory>: SelectCategoryViewFactoryProtocol {
    public typealias Quiz = Category.Quiz
    public typealias SelectCategoryViewModel = SelectCategoryViewModelImpl<Category, SelectCategoryInteractor<RepositoryImpl>>
    public typealias VoiceQuizViewModel = VoiceQuizViewModelImpl<Quiz, SoundEffectInteractor, VoiceQuizInteractor<Quiz, RepositoryImpl>>
    
    @MainActor
    public static func voiceQuizView(generator: VoiceQuizGenerator<Quiz>, lastRecord: GameRecord, dismiss: @escaping () -> Void) -> VoiceQuizView<VoiceQuizViewModel> {
        .init(viewModel: .init(useCase: .init(generator: generator, lastRecord: lastRecord), dismiss: dismiss))
    }
}
