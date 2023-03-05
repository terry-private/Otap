//
//  AppViewFactory.swift
//  
//
//  Created by 若江照仁 on 2023/02/24.
//

import SwiftUI
import Core
import CoreImpl
import FeatureSelectQuiz

public enum AppViewFactory {
    @MainActor
    public static func selectQuizView() -> some View {
        SelectQuizView<SelectQuizViewFactoryImpl, SelectQuizViewModelImpl>(
            viewModel: .init(
                selectors: [
                    ShapeQuizLevelSelector.basic1,
                    ColorQuizLevelSelector.basic1,
                    FunnyAnimalQuizLevelSelector.basic1,
                    CreatureQuizLevelSelector.advanced1,
                    FruitsAndVegetablesQuizLevelSelector.fruit1,
                    VehicleQuizLevelSelector.basic1,
                    NumberQuizLevelSelector.dice123,
                    HiraganaQuizLevelSelector.あ行
                ]
            )
        )
    }
}
