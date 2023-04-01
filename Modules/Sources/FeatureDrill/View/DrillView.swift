//
//  DrillView.swift
//  
//
//  Created by 若江照仁 on 2023/02/07.
//

import SwiftUI
import Core
import Components
import Extensions
import Repository

import ConfettiSwiftUI

public struct DrillView<ViewModel: DrillViewModelProtocol, Config: ConfigRepository>: View {
    @State var count: Int = 0
    @StateObject var viewModel: ViewModel
    @Namespace var startButton // TODO: 不要
    public init(viewModel: ViewModel) {
        _viewModel = .init(wrappedValue: viewModel)
    }
    
    public var body: some View {
        ZStack {
            switch viewModel.drillState {
            case .ready:
                VStack {
                    Spacer()
                    Text(ViewModel.Drill.title)
                        .font(.largeTitle)
                    
                    Spacer()
                    Text(viewModel.levelTitle)
                        .font(.title)
                    
                    Spacer()
                    Text("\(L10n.Drill.Conditions.title) \(viewModel.requirements)")
                        .font(.body)
                        .foregroundColor(.secondary)
                    
                    Grid(verticalSpacing: 16) {
                        GridRow {
                            Image(systemName: "star.fill")
                                .foregroundColor(viewModel.lastRecord.star1 ? .yellow : .gray)
                            Text(viewModel.star1Description)
                        }
                        GridRow {
                            Image(systemName: "star.fill")
                                .foregroundColor(viewModel.lastRecord.star2 ? .yellow : .gray)
                            Text(viewModel.star2Description)
                        }
                        GridRow {
                            Image(systemName: "star.fill")
                                .foregroundColor(viewModel.lastRecord.star3 ? .yellow : .gray)
                            Text(viewModel.star3Description)
                        }
                        Divider()
                        GridRow {
                            Text(L10n.Drill.record)
                            
                            Text(viewModel.lastRecord.time.map { String(format: "%.2f", $0) } ?? "--.--")
                        }
                        .padding(.horizontal, 40)
                    }
                    .font(.title3)
                    .fixedSize()
                    .padding(40)
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
                            Text(L10n.Drill.start)
                                .font(.system(size: 16, weight: .bold))
                            Spacer()
                        }
                    }
                    .disabled(viewModel.isLoading)
                    .padding(.vertical, 30)
                }
                .frame(maxWidth: .infinity)
            case let .gameOver(result):
                DrillResultView(
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
                        Grid(verticalSpacing: 4) {
                            GridRow {
                                Text(L10n.Drill.remain)
                                    .font(.body)
                                Text("\(viewModel.remainDrillCount)")
                                    .font(.system(size: 22))
                                    .monospacedDigit()
                                    .frame(width: 30)
                            }
                            GridRow {
                                Image(systemName: "xmark")
                                    .font(.body)
                                    .foregroundColor(.red)
                                    .padding()
                                Text("\(viewModel.wrongCount)")
                                    .font(.system(size: 17))
                                    .monospacedDigit()
                                    .frame(width: 30)
                            }
                        }
                        .fixedSize()
                        .layoutLikeSpacer()
                        .padding(.top, 40)
                        
                        // ----------------------------------------------------
                        // MARK: 🟡Center ProgressRings
                        // ----------------------------------------------------
                        ZStack {
                            ProgressRing(progress: (viewModel.timeLimit - viewModel.time) / viewModel.timeLimit, foregroundColor: viewModel.isWarning ? .red : .orange, lineWidth: 9)
                                .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
                                .padding(16)
                            
                            ProgressRing(progress: viewModel.drillProgress, foregroundColor: .blue, lineWidth: 9)
                                .padding(5)
                            ProgressRing(progress: viewModel.ghostProgress, foregroundColor: .mint, lineWidth: 3)
                            
                        }
                        .overlay {
                            TimeSecondsView(viewModel.remainTime)
                                .foregroundColor(viewModel.isWarning ? .red : .init(uiColor: .label))
                        }
                        .padding(.vertical, 5)
                        
                        // ----------------------------------------------------
                        // MARK: 👉Right Space
                        // ----------------------------------------------------
                        
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
                                Text(L10n.Drill.record)
                                    .font(.caption)
                                
                                Text(viewModel.lastRecord.time.map { String(format: "%.2f", $0) } ?? "--.--")
                                    .font(.caption)
                            }
                            .padding(.horizontal, 10)
                        }
                        .fixedSize()
                        .layoutLikeSpacer()
                        .padding(.top, 40)
                    }
                    .padding(.horizontal, 16)
                    .frame(maxWidth: .infinity)
                    .frame(height: 140)
                    
                    // ----------------------------------------------------
                    // MARK: Tap Buttons
                    // ----------------------------------------------------
                    SquareGrid(viewModel.currentDrill.options) { option in
                        Button {
                            viewModel.optionTapped(option)
                        } label: {
                            option.viewType.view()
                        }
                        .opacity(viewModel.drillState == .playing ? 1 : 0.2)
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
                        .disabled(viewModel.drillState != .playing)
                    }
                    .padding(.leading, Config.drillPanelLeadingPadding)
                    .padding(.trailing, Config.drillPanelTrailingPadding)
                    
                    // ----------------------------------------------------
                    // MARK: Speaker Button
                    // ----------------------------------------------------
                    BottomButton {
                        viewModel.speakerButtonTapped()
                    } label: {
                        Image(systemName: "speaker.wave.2.circle")
                            .font(.system(size: 26))
                        Spacer()
                        Text(L10n.Drill.speakAgain)
                            .font(.system(size: 16, weight: .bold))
                        Spacer()
                    }
                    .disabled(viewModel.drillState != .playing)
                    .padding(.vertical, 30)
                }
            }
            
            VStack {
                HStack(spacing: 80) {
                    if !viewModel.drillState.isGameOver {
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
                    
                    if !viewModel.drillState.isReady {
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
struct DrillView_Previews: PreviewProvider {
    typealias Drill = DrillDummy
    typealias SoundEffect = SoundEffectUseCaseDummy
    typealias UseCase = DrillUseCaseDummy
    typealias ViewModel = DrillViewModelImpl<Drill, SoundEffect, UseCase>
    static var previews: some View {
        DrillView<ViewModel, RepositoryImpl>(
            viewModel: .init(useCase: .init(), dismiss: {})
        )
    }
}
#endif
