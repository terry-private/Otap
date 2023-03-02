//
//  OtapApp.swift
//  Otap
//
//  Created by 若江照仁 on 2023/01/10.
//

import SwiftUI
import ViewFactoryImpl
import Utility
import FeatureSelectQuiz

@main
struct OtapApp: App {
    init() {
        SoundEffectInteractor.readyAllPlayer()
    }
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                SelectQuizView<SelectQuizViewFactoryImpl>()
            }
        }
    }
}
