//
//  OtapApp.swift
//  Otap
//
//  Created by 若江照仁 on 2023/01/10.
//

import SwiftUI
import Combine
import Components
import Feature
import Core
import UseCase
import Repository

@main
struct OtapApp: App {
    var body: some Scene {
        WindowGroup {
            SoundQuizView(
                viewModel: SoundQuizViewModel<
                    ColorQuiz,
                    SoundEffectInteractor,
                    SoundQuizInteractor<ColorQuiz, SoundQuizRepositoryImpl>
                >(
                    useCase: .init(
                        levelManager: ColorQuizLevels.level1.manager,
                        achievement: .init(
                            star1: false,
                            star2: false,
                            star3: false
                        )
                    )
                )
            )
        }
    }
}
