//
//  SelectLevelViewFactoryProtocol.swift
//  
//
//  Created by 若江照仁 on 2023/02/24.
//

import Foundation
import Core
import SwiftUI

public protocol SelectLevelViewFactoryProtocol {
    @MainActor
    static func voiceQuizView<Q: VoiceQuiz>(generator: VoiceQuizGenerator<Q>, lastRecord: GameRecord, dismiss: @escaping () -> Void) -> AnyView
    
    static func practiceModeView<Q: VoiceQuiz>(_ generator: VoiceQuizGenerator<Q>) -> AnyView
}

#if DEBUG
public enum SelectLevelViewFactoryDummy: SelectLevelViewFactoryProtocol {
    @MainActor
    public static func voiceQuizView<Q: VoiceQuiz>(generator: VoiceQuizGenerator<Q>, lastRecord: GameRecord, dismiss: @escaping () -> Void) -> AnyView {
        EmptyView().toAnyView()
    }
    
    public static func practiceModeView<Q: VoiceQuiz>(_ generator: VoiceQuizGenerator<Q>) -> AnyView {
        EmptyView().toAnyView()
    }
}
#endif
