//
//  TapGameForChildApp.swift
//  TapGameForChild
//
//  Created by 若江照仁 on 2023/01/10.
//

import SwiftUI
import AudioQuizViews
import SoundEffectUseCase
import Combine
@main
struct TapGameForChildApp: App {
    var body: some Scene {
        WindowGroup {
            AudioQuizView<AudioQuizViewModel<SoundEffectUseCase>>()
        }
    }
}

