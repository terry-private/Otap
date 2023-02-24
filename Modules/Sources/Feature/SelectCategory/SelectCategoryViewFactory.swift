//
//  File.swift
//  
//
//  Created by 若江照仁 on 2023/02/24.
//

import Foundation
import Core
import Utility
import Repository

public protocol SelectCategoryViewFactoryProtocol<Quiz> {
    associatedtype Quiz: VoiceQuiz
    associatedtype SelectCategoryViewModel: SelectCategoryViewModelProtocol<Quiz>
    associatedtype VoiceQuizViewModel: VoiceQuizViewModelProtocol<Quiz>
    
    static func voiceQuizView(generator: VoiceQuizGenerator<Quiz>, lastRecord: GameRecord, dismiss: @escaping () -> Void) -> VoiceQuizView<VoiceQuizViewModel>
}

#if DEBUG
public enum SelectCategoryViewFactoryDummy: SelectCategoryViewFactoryProtocol {
    public typealias Quiz = VoiceQuizDummy
    public typealias SoundEffect = SoundEffectUseCaseDummy
    public typealias UseCase = VoiceQuizUseCaseDummy
    public typealias SelectCategoryViewModel = SelectCategoryViewModelDummy
    public typealias VoiceQuizViewModel = VoiceQuizViewModelImpl<Quiz, SoundEffect, UseCase>
    
    @MainActor
    public static func voiceQuizView(generator: VoiceQuizGenerator<Quiz>, lastRecord: GameRecord, dismiss: @escaping () -> Void) -> VoiceQuizView<VoiceQuizViewModel> {
        .init(viewModel: .init(useCase: .init(), dismiss: {}))
    }
}
#endif
