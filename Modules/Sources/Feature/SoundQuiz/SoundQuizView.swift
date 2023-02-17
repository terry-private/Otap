//
//  SwiftUIView.swift
//  
//
//  Created by 若江照仁 on 2023/02/07.
//

import SwiftUI
import Core
import UseCase
import Components
import Extensions
import Repository

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
                        VStack {
                            Text(viewModel.currentQuiz.answer.call +  viewModel.currentQuiz.options.count.description + "個")
                        }
                        .layoutLikeSpacer()
                    }
                    .layoutLikeSpacer()
                    
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
                        HStack(alignment: .bottom, spacing: -1) {
                            Spacer()
                                .overlay(alignment: .bottomTrailing) {
                                    Text(viewModel.currentTimeSecond)
                                        .font(.system(size: 18, weight: .bold, design: .monospaced))
                                }
                            Text(viewModel.currentTimeDecimal)
                                .font(.system(size: 11, design: .monospaced))
                            Spacer()
                        }
                        .foregroundColor(viewModel.isWarning ? .red : .init(uiColor: .label))
                        .padding(.leading, 22)
                        .padding(.top, 5.5)
                    }
                    .padding(.vertical, 5)
                    
                    // ----------------------------------------------------
                    // MARK: 👉Right Space
                    // ----------------------------------------------------
                    VStack {
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
                        Grid(verticalSpacing: 4) {
                            GridRow {
                                Image(systemName: "star.fill")
                                    .foregroundColor(viewModel.achievement.star1 ? .yellow : .gray)
                                Text(viewModel.star1Description)
                                    .font(.system(size: 12))
                            }
                            GridRow {
                                Image(systemName: "star.fill")
                                    .foregroundColor(viewModel.achievement.star2 ? .yellow : .gray)
                                Text(viewModel.star2Description)
                                    .font(.system(size: 12))
                            }
                            GridRow {
                                Image(systemName: "star.fill")
                                    .foregroundColor(viewModel.achievement.star3 ? .yellow : .gray)
                                Text(viewModel.star3Description)
                                    .font(.system(size: 12))
                            }
                            Divider()
                            GridRow {
                                Text("レコード")
                                    .font(.system(size: 12))
                                
                                Text(viewModel.achievement.record.map { String(format: "%.2f", $0) } ?? "--.--")
                                    .font(.system(size: 12))
                            }
                        }
                        .layoutLikeSpacer()
                    }
                    .layoutLikeSpacer()
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
                        switch viewModel.getState(option) {
                        case .correct:
                            Image(systemName: "circle")
                                .resizable()
                                .aspectRatio(1, contentMode: .fill)
                                .foregroundColor(.red)
                                .padding()
                                .shadow(color: .black.opacity(0.2), radius: 8)
                        case .wrong:
                            Image(systemName: "xmark")
                                .resizable()
                                .aspectRatio(1, contentMode: .fill)
                                .scaledToFill()
                                .foregroundColor(.red)
                                .padding()
                                .shadow(color: .black.opacity(0.2), radius: 8)
                        default:
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
                                    .font(.system(size: 22))
                                Spacer()
                                Text("もう一度聞く")
                                    .font(.system(size: 14, weight: .bold))
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
                                            .font(.system(size: 22))
                                        Spacer()
                                        Text("スタート!!")
                                            .font(.system(size: 14, weight: .bold))
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
                Grid(verticalSpacing: 5) {
                    Text("クリア!!")
                        .font(.system(size: 30, weight: .bold))
                        .padding(.bottom, 10)
                    
                    GridRow {
                        Text(viewModel.star1Description)
                            .font(.system(size: 17))
                        starView(unlocked: grades.star1.unlocked, isFirst: grades.star1.isFirst)
                    }
                    
                    GridRow {
                        Text(viewModel.star2Description)
                            .font(.system(size: 17))
                        starView(unlocked: grades.star2.unlocked, isFirst: grades.star2.isFirst)
                    }
                    
                    GridRow {
                        Text(viewModel.star3Description)
                            .font(.system(size: 17))
                        starView(unlocked: grades.star3.unlocked, isFirst: grades.star3.isFirst)
                    }
                    
                    Divider()
                    
                    GridRow {
                        Text("タイム")
                            .font(.system(size: 17))
                        
                        Text(String(format: "%.2f", viewModel.time))
                            .font(.system(size: 17, weight: .bold))
                            .addNewBadge(viewModel.isNewRecord)
                    }
                }
                .padding(30)
                .background(.ultraThinMaterial)
                .cornerRadius(10)
                .padding(40)
            case .gameOver:
                Text("Game Over!!")
                    .font(.system(size: 22, weight: .bold))
                    .foregroundColor(.red)
            case .timeOver:
                Text("Time Over!!")
                    .font(.system(size: 22, weight: .bold))
                    .foregroundColor(.red)
            }
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
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background {
            if viewModel.isNewRecord || result.hasFirst {
                ConfettiView()
            }
        }
        .background(.ultraThinMaterial)
    }
    
    func starView(unlocked: Bool, isFirst: Bool) -> some View {
        Image(systemName: "star.fill")
            .resizable()
            .frame(width: 40, height: 36)
            .foregroundColor(unlocked ? .yellow : .gray)
            .addNewBadge(isFirst)
    }
}

struct SoundQuizView_Previews: PreviewProvider {
    static var previews: some View {
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
