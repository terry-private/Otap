//
//  SoundQuizViewModelProtocol.swift
//  
//
//  Created by 若江照仁 on 2023/02/08.
//

import Foundation
import Core
import SoundEffectUseCase
import SwiftUI

public enum GameState<Option: SoundQuizOption>: Equatable {
    case ready
    case playing
    case verifying(Option)
    case gameOver(GameResult)
}

public enum OptionState {
    case unanswered
    case unselected
    case correct
    case wrong
}

@MainActor
public protocol SoundQuizViewModelProtocol<Quiz>: ObservableObject {
    associatedtype Quiz: SoundQuiz
    var gameState: GameState<Quiz.Option> { get }
    var currentQuiz: Quiz { get }
    var isWarning: Bool { get }
    var isLoading: Bool { get }
    var isNewRecord: Bool { get }
    var achievement: Achievement { get }
    var star1Description: String { get }
    var star2Description: String { get }
    var star3Description: String { get }
    var time: Double { get }
    var timeLimit: Double { get }
    var quizProgress: Double { get }
    var ghostProgress: Double { get }
    var currentTimeSecond: String { get }
    var currentTimeDecimal: String { get }
    
    func start()
    func restart()
    func speakerButtonTapped()
    func optionTapped(_ option: Quiz.Option)
    func getState(_ option: Quiz.Option) -> OptionState
}

@MainActor
public final class SoundQuizViewModel<
    Quiz: SoundQuiz,
    SoundEffect: SoundEffectUseCase,
    UseCase: SoundQuizUseCase<Quiz>
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
    
    // ------------------------------------------------
    // MARK: init
    // ------------------------------------------------
    public init(useCase: UseCase) {
        self.useCase = useCase
        currentQuiz = useCase.nextQuiz()
    }
}

// MARK: - AudioQuizViewModelProtocol methods
extension SoundQuizViewModel: SoundQuizViewModelProtocol {
    public var star1Description: String { useCase.star1Description }
    public var star2Description: String { useCase.star2Description }
    public var star3Description: String { useCase.star3Description }
    
    public var isNewRecord: Bool {
        guard case let .gameOver(result) = gameState, case .success = result else {
            return false
        }
        return time < achievement.record ?? .infinity
    }
    public var timeLimit: Double {
        useCase.timeLimit
    }
    public var achievement: Achievement {
        useCase.achievement
    }
    public var ghostProgress: Double {
        guard let record = achievement.record else {
            return .zero
        }
        return time / record
    }
    public var currentTime: String {
        String(format: "%.2f", time)
    }
    public var currentTimeSecond: String {
        "\(Int(time))"
    }
    public var currentTimeDecimal: String {
       ".\(String(format: "%02d", Int(time * 100) - Int(time) * 100))"
    }
    
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
        Task {
            try? await Task.sleep(seconds: 0.4)
            useCase.answer(isCorrect: isCorrect)
            guard currentQuizIndex < useCase.quizCount else {
                stopTimer()
                gameState = .gameOver(useCase.gameResult(time: time))
                return
            }
            if isCorrect {
                currentQuiz = useCase.nextQuiz()
            } else {
                switch useCase.penalty {
                case .gameOver:
                    stopTimer()
                    gameState = .gameOver(useCase.gameResult(time: time))
                    return
                case .shuffle:
                    try await shuffle(3)
                }
            }
            
            // シャッフルアニメーション中などにタイムオーバーになっている場合を考慮している
            guard case .verifying = gameState else {
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
        if currentQuiz.answer == option {
            return .correct
        } else {
            return .wrong
        }
    }
}

// MARK: - 🚪🧮private methods
private extension SoundQuizViewModel {
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
            try? await Task.sleep(seconds: 0.1)
            try await shuffle(count - 1)
        }
    }
}
