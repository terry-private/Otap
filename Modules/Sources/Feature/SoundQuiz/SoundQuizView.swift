//
//  SwiftUIView.swift
//  
//
//  Created by 若江照仁 on 2023/02/07.
//

import SwiftUI
import Core
import Components
import Extensions

public struct SoundQuizView<ViewModel: SoundQuizViewModelProtocol>: View {
    @StateObject var viewModel: ViewModel
    @Namespace var startButton
    public init(viewModel: ViewModel) {
        _viewModel = .init(wrappedValue: viewModel)
    }
    
    public var body: some View {
        ZStack {
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
                        Rectangle()
                            .fill(option.foregroundColor.gradient)
                            .overlay {
                                if let imageName = option.imageName {
                                    Image(imageName)
                                }
                            }
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
                Button {
                    viewModel.speakerButtonTapped()
                } label: {
                    Capsule()
                        .overlay {
                            HStack {
                                Image(systemName: "speaker.wave.2.circle")
                                    .font(.system(size: 26))
                                Spacer()
                                Text("もう一度聞く")
                                    .font(.system(size: 16, weight: .bold))
                                Spacer()
                            }
                            .foregroundColor(.white)
                            .padding(.horizontal, 20)
                        }
                        .frame(width: 180, height: 48)
                        .shadow(color: .black.opacity(0.2), radius: 8)
                }
                .disabled(viewModel.gameState != .playing)
                .padding(.vertical, 30)
            }
            
            switch viewModel.gameState {
            case .ready:
                VStack {
                    Spacer()
                    Text("Ready")
                        .font(.title)
                    Spacer()
                    
                    Button {
                        viewModel.start()
                    } label: {
                        Capsule()
                            .overlay {
                                HStack {
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
                                .foregroundColor(.white)
                                .padding(.horizontal, 20)
                            }
                            .frame(width: 180, height: 48)
                            .shadow(color: .black.opacity(0.2), radius: 8)
                    }
                    .padding(.vertical, 30)
                    .disabled(viewModel.isLoading)
                }
                .frame(maxWidth: .infinity)
                .background(.ultraThinMaterial)
            case let .gameOver(result):
                resultView(result: result)
            default:
                EmptyView()
            }
            
            VStack {
                HStack(spacing: 80) {
                    Button {
                        
                    } label: {
                        Capsule()
                            .frame(width: 60, height: 30)
                            .foregroundColor(.red)
                            .overlay {
                                Image(systemName: "xmark")
                                    .foregroundColor(.white)
                            }
                    }
                    
                    Spacer()
                    
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
                .padding(.horizontal, 16)
                Spacer()
            }
            .zIndex(viewModel.gameState == .ready ? -1 : 0)
        }
        .background {
            Color(uiColor: .secondarySystemBackground)
                .ignoresSafeArea()
        }
    }
}

private extension SoundQuizView {
    func resultView(result: GameResult) -> some View {
        VStack {
            Spacer()
            switch result {
            case .success(let grades):
                Grid(verticalSpacing: 23) {
                    Text("Congratulations!!")
                        .font(.title)
                        .italic()
                        .padding(.bottom, 5)
                    
                    GridRow {
                        Text(viewModel.star1Description)
                        starView(unlocked: grades.star1.unlocked, isFirst: grades.star1.isFirst)
                    }
                    
                    GridRow {
                        Text(viewModel.star2Description)
                        starView(unlocked: grades.star2.unlocked, isFirst: grades.star2.isFirst)
                    }
                    
                    GridRow {
                        Text(viewModel.star3Description)
                        starView(unlocked: grades.star3.unlocked, isFirst: grades.star3.isFirst)
                    }
                    
                    Divider()
                    
                    GridRow {
                        Text("タイム")
                        
                        Text(String(format: "%.2f", viewModel.time))
                            .font(.headline)
                            .addTextAnimationBadge(grades.isNewTimeRecord)
                    }
                }
                .padding(30)
                .background(.ultraThinMaterial)
                .cornerRadius(20)
                .fixedSize()
            case .gameOver:
                Text("Game Over!!")
                    .font(.title)
                    .foregroundColor(.red)
                    .padding(40)
            case .timeOver:
                Text("Time Over!!")
                    .font(.title)
                    .foregroundColor(.red)
                    .padding(40)
            }
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background {
            if result.hasFirst {
                ConfettiView()
            }
        }
        .background(.ultraThinMaterial)
    }
    
    func starView(unlocked: Bool, isFirst: Bool) -> some View {
        Image(systemName: "star.fill")
            .font(.system(size: 30))
            .foregroundColor(unlocked ? .yellow : .gray)
            .addTextAnimationBadge(isFirst)
    }
}

#if DEBUG
import UseCase
struct SoundQuizView_Previews: PreviewProvider {
    typealias Quiz = SoundQuizDummy
    typealias SoundEffect = SoundEffectUseCaseDummy
    typealias UseCase = SoundQuizUseCaseDummy
    typealias ViewModel = SoundQuizViewModelImpl<Quiz, SoundEffect, UseCase>
    static var previews: some View {
        SoundQuizView(
            viewModel: ViewModel(useCase: .init())
        )
    }
}
#endif
