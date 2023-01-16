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
import AudioQuiz

struct ContentView<Quiz: AudioQuiz>: View {
    
    @State var selectedChoice: Quiz.Choice?
    @State var quiz: Quiz
    let speechSynthesizer = AVSpeechSynthesizer()
    init(quiz: Quiz = ColorQuiz()) {
        self._quiz = .init(wrappedValue: quiz)
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
            
            AudioQuizChoicesView(
                selectedChoice: selectedChoice,
                quiz: quiz,
                choiceTapped: { choice in
                    guard selectedChoice == nil else {
                        return
                    }
                    selectedChoice = choice
                    playSoundEffect()
                    Task { @MainActor in
                        try? await Task.sleep(nanoseconds: 500_000_000)
                        quiz = ColorQuiz() as! Quiz
                        selectedChoice = nil
                        speakAnswer()
                    }
                }, getState: { choice in
                    guard let selectedChoice else {
                        return .unanswered
                    }
                    guard selectedChoice == choice else {
                        return .unselected
                    }
                    if quiz.answer == choice {
                        return .correct
                    } else {
                        return .wrong
                    }
                }
            )
            .padding(16)
        }
        .background { Color(uiColor: .tertiarySystemBackground) }
        .onAppear {
            speakAnswer()
        }
    }
    
    func speakAnswer() {
        let utterance = AVSpeechUtterance(string: quiz.answer.call)
        speechSynthesizer.speak(utterance)
    }
    
    func playSoundEffect() {
        if quiz.answer == selectedChoice {
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
