//
//  VoiceQuizView.swift
//  
//
//  Created by 若江照仁 on 2023/02/07.
//

import SwiftUI
import Core
import Components
import Extensions

import ConfettiSwiftUI

public struct VoiceQuizView<ViewModel: VoiceQuizViewModelProtocol>: View {
    @State var count: Int = 0
    @StateObject var viewModel: ViewModel
    @Namespace var startButton
    public init(viewModel: ViewModel) {
        _viewModel = .init(wrappedValue: viewModel)
    }
    
    public var body: some View {
        ZStack {
            switch viewModel.gameState {
            case .ready:
                VStack {
                    Spacer()
                    Text("Ready")
                        .font(.title)
                    
                    Spacer()
                    
                    BottomButton {
                        viewModel.start()
                    } label: {
                        if viewModel.isLoading {
                            ProgressView()
                        } else {
                            Image(systemName: "speaker.wave.2.circle")
                                .font(.system(size: 26))
                            Spacer()
                            Text("スタート!!")
                                .font(.system(size: 16, weight: .bold))
                            Spacer()
                        }
                    }
                    .disabled(viewModel.isLoading)
                    .padding(.vertical, 30)
                }
                .frame(maxWidth: .infinity)
            case let .gameOver(result):
                VoiceQuizResultView(
                    result: result,
                    star1: viewModel.star1Description,
                    star2: viewModel.star2Description,
                    star3: viewModel.star3Description) {
                        viewModel.dismiss()
                    }
            default:
                VStack(spacing: 0) {
                    HStack {
                        // ----------------------------------------------------
                        // MARK: 👈Left Space
                        // ----------------------------------------------------
                        VStack {
                            
                                Text(viewModel.currentQuiz.answer.call +  viewModel.currentQuiz.options.count.description + "個")
                        }
                        .layoutLikeSpacer()
                        .padding(.top, 40)
                        
                        // ----------------------------------------------------
                        // MARK: 🟡Center ProgressRings
                        // ----------------------------------------------------
                        ZStack {
                            ProgressRing(progress: (viewModel.timeLimit - viewModel.time) / viewModel.timeLimit, foregroundColor: viewModel.isWarning ? .red : .orange, lineWidth: 9)
                                .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
                                .padding(16)
                            
                            ProgressRing(progress: viewModel.quizProgress, foregroundColor: .blue, lineWidth: 9)
                                .padding(5)
                            ProgressRing(progress: viewModel.ghostProgress, foregroundColor: .mint, lineWidth: 3)
                            
                        }
                        .overlay {
                            TimeSecondsView(viewModel.time)
                                .foregroundColor(viewModel.isWarning ? .red : .init(uiColor: .label))
                        }
                        .padding(.vertical, 5)
                        
                        // ----------------------------------------------------
                        // MARK: 👉Right Space
                        // ----------------------------------------------------
                        VStack {
                            Grid(verticalSpacing: 4) {
                                GridRow {
                                    Image(systemName: "star.fill")
                                        .foregroundColor(viewModel.lastRecord.star1 ? .yellow : .gray)
                                    Text(viewModel.star1Description)
                                        .font(.caption)
                                }
                                GridRow {
                                    Image(systemName: "star.fill")
                                        .foregroundColor(viewModel.lastRecord.star2 ? .yellow : .gray)
                                    Text(viewModel.star2Description)
                                        .font(.caption)
                                }
                                GridRow {
                                    Image(systemName: "star.fill")
                                        .foregroundColor(viewModel.lastRecord.star3 ? .yellow : .gray)
                                    Text(viewModel.star3Description)
                                        .font(.caption)
                                }
                                Divider()
                                GridRow {
                                    Text("レコード")
                                        .font(.caption)
                                    
                                    Text(viewModel.lastRecord.time.map { String(format: "%.2f", $0) } ?? "--.--")
                                        .font(.caption)
                                }
                            }
                            .layoutLikeSpacer()
                        }
                        .layoutLikeSpacer()
                        .padding(.top, 40)
                    }
                    .padding(.horizontal, 16)
                    .frame(maxWidth: .infinity)
                    .frame(height: 140)
                    
                    // ----------------------------------------------------
                    // MARK: Tap Buttons
                    // ----------------------------------------------------
                    SquareGrid(viewModel.currentQuiz.options) { option in
                        Button {
                            viewModel.optionTapped(option)
                        } label: {
                            option.viewType.view()
                        }
                        .opacity(viewModel.gameState == .playing ? 1 : 0.2)
                        .overlay {
                            if case let .selected(isCorrect) = viewModel.getState(option) {
                                Image(systemName: isCorrect ? "circle" : "xmark")
                                    .resizable()
                                    .aspectRatio(1, contentMode: .fill)
                                    .foregroundColor(.red)
                                    .padding()
                                    .shadow(color: .black.opacity(0.2), radius: 8)
                            } else {
                                EmptyView()
                            }
                        }
                        .disabled(viewModel.gameState != .playing)
                    }
                    
                    // ----------------------------------------------------
                    // MARK: Speaker Button
                    // ----------------------------------------------------
                    BottomButton {
                        viewModel.speakerButtonTapped()
                    } label: {
                        Image(systemName: "speaker.wave.2.circle")
                            .font(.system(size: 26))
                        Spacer()
                        Text("もう一度聞く")
                            .font(.system(size: 16, weight: .bold))
                        Spacer()
                    }
                    .disabled(viewModel.gameState != .playing)
                    .padding(.vertical, 30)
                }
            }
            
            VStack {
                HStack(spacing: 80) {
                    if !viewModel.gameState.isGameOver {
                        Button {
                            viewModel.dismiss()
                        } label: {
                            Capsule()
                                .frame(width: 60, height: 30)
                                .foregroundColor(.red)
                                .overlay {
                                    Image(systemName: "xmark")
                                        .foregroundColor(.white)
                                }
                        }
                    }
                    
                    Spacer()
                    
                    if !viewModel.gameState.isReady {
                        Button {
                            viewModel.restart()
                        } label: {
                            Capsule()
                                .frame(width: 60, height: 30)
                                .foregroundColor(.green)
                                .overlay {
                                    Image(systemName: "arrow.clockwise")
                                        .foregroundColor(.white)
                                }
                        }
                    }
                }
                .padding(.horizontal, 16)
                Spacer()
            }
        }
        .background {
            Color(uiColor: .secondarySystemBackground)
                .ignoresSafeArea()
        }
    }
}

#if DEBUG
import Utility
struct VoiceQuizView_Previews: PreviewProvider {
    typealias Quiz = VoiceQuizDummy
    typealias SoundEffect = SoundEffectUseCaseDummy
    typealias UseCase = VoiceQuizUseCaseDummy
    typealias ViewModel = VoiceQuizViewModelImpl<Quiz, SoundEffect, UseCase>
    static var previews: some View {
        VoiceQuizView(
            viewModel: ViewModel(useCase: .init(), dismiss: {})
        )
    }
}
#endif
