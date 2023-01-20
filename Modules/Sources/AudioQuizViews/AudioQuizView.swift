//
//  AudioQuizView.swift
//  TapGameForChild
//
//  Created by 若江照仁 on 2023/01/10.
//

import SwiftUI
import AVFoundation
import OrientationAdaptiveViews
import AudioQuiz
import SoundEffectUseCase

public struct AudioQuizView<ViewModel: AudioQuizViewModelProtocol>: View {
    @StateObject var viewModel: ViewModel
    
    public init(viewModel: ViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    public init() {
        _viewModel = StateObject(wrappedValue: AudioQuizViewModel<SoundEffectUseCase>(
            quizzes: (0..<30).map { _ in .colorQuiz(ColorQuiz()) }) as! ViewModel)
    }
    
    public var body: some View {
        ZStack {
            
            if !viewModel.isEmpty {
                AudioQuizChoicesView(
                    selectedIndex: viewModel.selectedIndex,
                    quiz: viewModel.currentQuizType.quiz,
                    choiceTapped: { index in viewModel.choiceTapped(index) },
                    getState: { index in viewModel.getState(index) }
                )
                .padding(18)
            }
            VStack {
                Button {
                    viewModel.speakerButtonTapped()
                } label: {
                    Image(systemName: "speaker.wave.2.circle")
                        .resizable()
                        .frame(width: 48, height: 48)
                        .foregroundColor(.blue)
                }
                .padding(40)
                
                Spacer()
                
                Text(viewModel.currentQuizType.quiz.answer.call +  viewModel.currentQuizType.quiz.choices.count.description + "個")
                    .padding(60)
            }
        }
        .background {
            Color(uiColor: .secondarySystemBackground)
                .ignoresSafeArea()
            
        }
        .onAppear {
            viewModel.onAppear()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        AudioQuizView<AudioQuizViewModel<SoundEffectUseCase>>()
    }
}
