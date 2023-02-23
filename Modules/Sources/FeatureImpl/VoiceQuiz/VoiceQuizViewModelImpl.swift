//
//  VoiceQuizViewModelProtocol.swift
//  
//
//  Created by 若江照仁 on 2023/02/08.
//

import Foundation
import Core
import SwiftUI
import UseCase
import Feature

@MainActor
public final class VoiceQuizViewModelImpl<
    Quiz: VoiceQuiz,
    SoundEffect: SoundEffectUseCase,
    UseCase: VoiceQuizUseCase<Quiz>
>: ObservableObject {
    // ------------------------------------------------
    // MARK: 🚪📦private properties
    // ------------------------------------------------
    private let useCase: UseCase
    private var currentQuizIndex: Int = 0
    private var timer: Timer?
    
    // ------------------------------------------------
    // MARK: 🌎📦AudioQuizViewModelProtocol properties
    // ------------------------------------------------
    @Published private(set) public var gameState: GameState<Quiz.Option> = .ready
    @Published private(set) public var time: Double = 0
    @Published private(set) public var quizProgress: Double = .zero
    @Published private(set) public var isWarning: Bool = false
    @Published private(set) public var isLoading: Bool = false
    @Published private(set) public var currentQuiz: Quiz
    public let dismiss: () -> Void
    
    // ------------------------------------------------
    // MARK: init
    // ------------------------------------------------
    public init(useCase: UseCase, dismiss: @escaping () -> Void) {
        self.useCase = useCase
        self.dismiss = dismiss
        currentQuiz = useCase.nextQuiz()
        SoundEffect.readyAllPlayer() // TODO: いずれはAppDelegateなどアプリ起動後一度だけ処理する箇所で呼びたい
    }
}

// MARK: - AudioQuizViewModelProtocol get only properties
extension VoiceQuizViewModelImpl: VoiceQuizViewModelProtocol {
    public var star1Description: String { useCase.star1Description }
    public var star2Description: String { useCase.star2Description }
    public var star3Description: String { useCase.star3Description }
    
    public var timeLimit: Double { useCase.timeLimit }
    public var lastRecord: GameRecord { useCase.lastRecord }
    public var ghostProgress: Double {
        guard let lastRecordTime = lastRecord.time else {
            return .zero
        }
        return time / lastRecordTime
    }
}

// MARK: - AudioQuizViewModelProtocol methods
extension VoiceQuizViewModelImpl {
    public func start() {
        Task {
            timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { [weak self] _ in
                guard let self else { return }
                Task { @MainActor in
                    self.time += 0.01
                    switch self.time {
                    case 0..<self.timeLimit - 10:
                        break
                    case self.timeLimit-10 ..< self.timeLimit:
                        self.isWarning = true
                    default:
                        self.stopTimer()
                        self.gameState = .gameOver(self.useCase.gameResult(time: self.time))
                    }
                }
            }
        }
        currentQuiz = useCase.nextQuiz()
        startQuiz()
    }
    
    public func restart() {
        stopTimer()
        time = .zero
        currentQuizIndex = 0
        quizProgress = .zero
        isWarning = false
        gameState = .ready
        Task {
            isLoading = true
            do {
                try await useCase.refresh()
                isLoading = false
            } catch {
                print(error.localizedDescription)
                isLoading = false
            }
        }
    }
    
    public func speakerButtonTapped() {
        speak()
    }
    
    public func optionTapped(_ option: Quiz.Option) {
        guard case .playing = gameState else {
            return
        }
        gameState = .verifying(option)
        let isCorrect = option == currentQuiz.answer
        playSoundEffect(isCorrect)
        if isCorrect {
            currentQuizIndex += 1
            withAnimation(.easeInOut(duration: 0.5)) {
                quizProgress = Double(currentQuizIndex) / Double(useCase.quizCount)
            }
        }
        
        if currentQuizIndex == useCase.quizCount || (!isCorrect && useCase.penalty == .gameOver) {
            stopTimer()
        }
        Task {
            try? await Task.sleep(seconds: 0.4)
            
            useCase.recordQuizResult(isCorrect: isCorrect)
            guard currentQuizIndex < useCase.quizCount else {
                gameState = .gameOver(useCase.gameResult(time: time))
                return
            }
            if isCorrect {
                currentQuiz = useCase.nextQuiz()
            } else {
                switch useCase.penalty {
                case .gameOver:
                    gameState = .gameOver(useCase.gameResult(time: time))
                    return
                case .shuffle:
                    gameState = .penaltyTime
                    try await shuffle(4)
                }
            }
            
            // シャッフルアニメーション中などにタイムオーバーになっている場合を考慮している
            guard gameState.shouldStartQuiz else {
                return
            }
            startQuiz()
        }
    }
    
    public func getState(_ option: Quiz.Option) -> OptionState {
        guard case .verifying(let selectedOption) = gameState else {
            return .unanswered
        }
        guard selectedOption == option else {
            return .unselected
        }
        return .selected(isCorrect: currentQuiz.answer == option)
    }
}

// MARK: - 🚪🧮private methods
private extension VoiceQuizViewModelImpl {
    func startQuiz() {
        gameState = .playing
        speak()
    }
    
    func option(from id: Quiz.Option.ID) -> Quiz.Option {
        currentQuiz.options.first { $0.id == id }! // force unwrap!
    }
    
    func speak() {
        SoundEffect.speak(currentQuiz.answer.call)
    }
    
    func playSoundEffect(_ isCorrect: Bool) {
        if isCorrect {
            SoundEffect.playCorrect()
        } else {
            SoundEffect.playWrong()
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    func shuffle(_ count: Int = 1) async throws {
        withAnimation(.spring(response: 0.3, dampingFraction: 0.5)) {
            currentQuiz = .init(options: currentQuiz.options.shuffled(), answer: currentQuiz.answer)
        }
        if count > 0 {
            try? await Task.sleep(seconds: 0.05)
            try await shuffle(count - 1)
        }
    }
}
