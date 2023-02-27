//
//  OtapApp.swift
//  Otap
//
//  Created by 若江照仁 on 2023/01/10.
//

import SwiftUI
import ViewFactoryImpl
import CoreImpl
import Feature
import FeatureSelectQuiz

@main
struct OtapApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
//                SelectLevelView<SelectLevelViewFactoryImpl<ColorQuizLevelSelector>>(viewModel: .init())
//                SelectLevelView<SelectLevelViewFactoryImpl<AnimalQuizLevelSelector>>(viewModel: .init())
                SelectQuizView()
            }
        }
    }
}
