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
    
    @State var size: CGSize = .zero
    @State var maxY: CGFloat = .zero
    
    public init(viewModel: ViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    public init() {
        _viewModel = StateObject(wrappedValue: AudioQuizViewModel<SoundEffectUseCase>(
            quizzes: (0..<30).map { _ in .colorQuiz(ColorQuiz()) }) as! ViewModel)
    }
    
    public var body: some View {
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
            
            VStack {
                
            }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .onChangeFrame {
                    size = CGSize(width: $0.width - 18 * 2, height: $0.height)
                    print("🐱", size, $0, viewModel.currentQuizType.quiz.choices.count)
                }
                .overlay {
                    if !viewModel.isEmpty {
                        AudioQuizChoicesView(
                            size,
                            selectedIndex: viewModel.selectedIndex,
                            quiz: viewModel.currentQuizType.quiz,
                            choiceTapped: { index in viewModel.choiceTapped(index) },
                            getState: { index in viewModel.getState(index) }
                        )
                        .padding(.vertical, 18)
                    }
                }
            
            Text("\(viewModel.currentIndex + 1)問目 / \(viewModel.quizzesCount)")
            
            Text(viewModel.currentQuizType.quiz.answer.call +  viewModel.currentQuizType.quiz.choices.count.description + "個")
                .padding(60)
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

private struct SizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {}
}

public extension View {
    func onChangeFrame( _ block: @escaping (CGSize) -> Void) -> some View {
        background(
            GeometryReader {
                Color.clear
                    .preference(key: SizePreferenceKey.self, value: $0.size)
            }
        )
        .onPreferenceChange(SizePreferenceKey.self, perform: block)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        AudioQuizView<AudioQuizViewModel<SoundEffectUseCase>>()
    }
}
