//
//  ContentView.swift
//  TapGameForChild
//
//  Created by 若江照仁 on 2023/01/10.
//

import SwiftUI
import AVFoundation
import SoundEffectUseCase
import OrientationAdaptiveViews
import TapGame

struct ContentView<Game: TapGame>: View {
    
    @State var tappedOption: Game.Option?
    @State var game: Game
    let speechSynthesizer = AVSpeechSynthesizer()
    init(game: Game = ColorGame()) {
        self._game = .init(wrappedValue: game)
    }
    var body: some View {
        ZStack {
            OAStackView {
                Button {
                    guard !speechSynthesizer.isSpeaking else { return }
                    speakAnswer()
                } label: {
                    Image(systemName: "speaker.wave.2.circle")
                        .resizable()
                        .frame(width: 48, height: 48)
                        .foregroundColor(.blue)
                }
                .padding(40)
                
                Spacer()
            }
            
            TapOptionsView(
                tappedOption: tappedOption,
                game: game,
                optionTapped: { option in
                    guard tappedOption == nil else {
                        return
                    }
                    tappedOption = option
                    playSoundEffect()
                    Task { @MainActor in
                        try? await Task.sleep(nanoseconds: 500_000_000)
                        game = ColorGame() as! Game
                        tappedOption = nil
                        speakAnswer()
                    }
                }, getState: { option in
                    guard let tappedOption else {
                        return .unanswered
                    }
                    guard tappedOption == option else {
                        return .unselected
                    }
                    if game.answer == option {
                        return .correct
                    } else {
                        return .wrong
                    }
                }
            )
            .padding(16)
        }
        .onAppear {
            speakAnswer()
        }
    }
    
    func speakAnswer() {
        let utterance = AVSpeechUtterance(string: game.answer.call)
        speechSynthesizer.speak(utterance)
    }
    
    func playSoundEffect() {
        if game.answer == tappedOption {
            SoundEffectUseCase.playCorrect()
        } else {
            SoundEffectUseCase.playWrong()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
