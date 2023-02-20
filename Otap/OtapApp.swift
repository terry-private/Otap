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
import CoreImpl
import UseCaseImpl
import RepositoryImpl

@main
struct OtapApp: App {
    var body: some Scene {
        WindowGroup {
            SoundQuizView(
                viewModel: SoundQuizViewModelImpl<
                    ColorQuiz,
                    SoundEffectInteractor,
                    SoundQuizInteractor<ColorQuiz, RepositoryImpl>
                >(
                    useCase: .init(
                        generator: ColorQuizCategory.level1.generator,
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
