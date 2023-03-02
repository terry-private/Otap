//
//  SelectQuizViewFactory.swift
//  
//
//  Created by 若江照仁 on 2023/03/02.
//

import SwiftUI
import Core
import CoreImpl
import Feature

public protocol SelectQuizViewFactoryProtocol {
    associatedtype ViewModel: SelectQuizViewModelProtocol
    @MainActor
    static func quizLevelSelectorView<T: VoiceQuizLevelSelector>(_ selector: T) -> AnyView
    static var viewModel: ViewModel { get }
}

#if DEBUG
enum SelectQuizViewFactoryDummy: SelectQuizViewFactoryProtocol {
    typealias ViewModel = SelectQuizViewModelImpl
    
    @MainActor
    static func quizLevelSelectorView<T>(_ selector: T) -> AnyView where T : VoiceQuizLevelSelector {
        AnyView(T.previewQuiz.answer.viewType.view())
    }
    static var viewModel: SelectQuizViewModelImpl {
        .init(selectors: [VoiceQuizLevelSelectorDummy.level1, VoiceQuizLevelSelectorDummy.level2])
    }
}
#endif
