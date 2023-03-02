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
}

#if DEBUG
public enum SelectLevelViewFactoryDummy: SelectLevelViewFactoryProtocol {
    @MainActor
    public static func voiceQuizView<Q: VoiceQuiz>(generator: VoiceQuizGenerator<Q>, lastRecord: GameRecord, dismiss: @escaping () -> Void) -> AnyView {
        EmptyView().toAnyView()
    }
}
#endif
