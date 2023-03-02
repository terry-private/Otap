//
//  SelectQuizViewFactory.swift
//  
//
//  Created by 若江照仁 on 2023/03/02.
//

import SwiftUI
import Core

public protocol SelectQuizViewFactoryProtocol {
    @MainActor
    static func quizLevelSelectorView<T: VoiceQuizLevelSelector>(_ selector: T) -> AnyView
}

#if DEBUG
enum SelectQuizViewFactoryDummy: SelectQuizViewFactoryProtocol {
    @MainActor
    static func quizLevelSelectorView<T>(_ selector: T) -> AnyView where T : VoiceQuizLevelSelector {
        AnyView(T.previewQuiz.answer.viewType.view())
    }
}
#endif
