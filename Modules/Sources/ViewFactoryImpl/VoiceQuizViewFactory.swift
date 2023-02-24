//
//  VoiceQuizViewFactory.swift
//  
//
//  Created by 若江照仁 on 2023/02/24.
//

import Foundation
import Core
import Feature
import Repository
import Utility

//public struct VoiceQuizViewFactoryImpl<Quiz: VoiceQuiz>: VoiceQuizViewFactoryProtocol {
//    public typealias ViewModel = VoiceQuizViewModelImpl<Quiz, SoundEffectInteractor, VoiceQuizInteractor<Quiz, RepositoryImpl>>
//    public let generator: VoiceQuizGenerator<Quiz>
//    public let lastRecord: GameRecord
//    public let dismiss: () -> Void
//
//    @MainActor
//    public var voiceQuizViewModel: ViewModel {
//        .init(useCase: .init(generator: generator, lastRecord: lastRecord), dismiss: dismiss)
//    }
//
//    public init(generator: VoiceQuizGenerator<Quiz>, lastRecord: GameRecord, dismiss: @escaping () -> Void) {
//        self.generator = generator
//        self.lastRecord = lastRecord
//        self.dismiss = dismiss
//    }
//
//}
