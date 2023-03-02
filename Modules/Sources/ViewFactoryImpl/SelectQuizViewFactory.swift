//
//  File.swift
//  
//
//  Created by 若江照仁 on 2023/03/02.
//

import SwiftUI
import Core
import CoreImpl
import Feature
import FeatureSelectQuiz

public enum SelectQuizViewFactoryImpl: SelectQuizViewFactoryProtocol {
    public typealias ViewModel = SelectQuizViewModelImpl
    
    @MainActor
    public static func quizLevelSelectorView<T: VoiceQuizLevelSelector>(_ selector: T) -> AnyView {
        SelectLevelView<SelectLevelViewFactoryImpl<T>>(viewModel: .init()).toAnyView()
    }
    
    public static var viewModel: ViewModel {
        .init(selectors: [
            ColorQuizLevelSelector.basic1,
            FunnyAnimalQuizLevelSelector.basic1,
            CreatureQuizLevelSelector.advanced1
        ])
    }
}
