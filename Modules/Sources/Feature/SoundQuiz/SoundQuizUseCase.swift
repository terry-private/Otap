//
//  SoundQuizUseCase.swift
//  
//
//  Created by 若江照仁 on 2023/02/15.
//

import Foundation
import Combine
import Core
import Repository

public enum QuizVerificationResult: Equatable {
    case correct
    case wrong(PenaltyType)
}

public struct Grades: Equatable {
    public enum StarState: Equatable {
        case unlocked(isFirst: Bool)
        case locked
        public init(before: Bool, after: Bool) {
            if before && after {
                self = .unlocked(isFirst: false)
            } else if after {
                self = .unlocked(isFirst: true)
            } else {
                self = .locked
            }
        }
        var unlocked: Bool {
            switch self {
            case .locked: return false
            default: return true
            }
        }
        var isFirst: Bool {
            switch self {
            case let .unlocked(isFirst):
                return isFirst
            default: return false
            }
        }
    }
    public var star1: StarState
    public var star2: StarState
    public var star3: StarState
    var hasFirst: Bool {
        star1.isFirst || star2.isFirst || star3.isFirst
    }
}

public enum GameResult: Equatable {
    case success(Grades)
    case timeOver
    case gameOver
    
    var hasFirst: Bool {
        guard case let .success(grades) = self else {
            return false
        }
        return grades.hasFirst
    }
}

// 📝 use case
public protocol SoundQuizUseCase<Quiz> {
    associatedtype Quiz: SoundQuiz
    var achievement: Achievement { get }
    var timeLimit: Double { get }
    var penalty: PenaltyType { get }
    
    var quizCount: Int { get }
    
    var star1Description: String { get }
    var star2Description: String { get }
    var star3Description: String { get }
    
    func answer(isCorrect: Bool)
    func nextQuiz() -> Quiz
    func gameResult(time: Double) -> GameResult
    func refresh() async throws
}


public final class SoundQuizInteractor<Quiz: SoundQuiz, Repository: SoundQuizRepositoryProtocol> {
    // ------------------------------------------------
    // MARK: 🌎📦public stored properties
    // ------------------------------------------------
    public var achievement: Achievement
    
    // ------------------------------------------------
    // MARK: 🚪📦private stored properties
    // ------------------------------------------------
    private let levelManager: SoundQuizLevelManager<Quiz>
    private var quizzes: [Quiz]
    private var correctCount: Int = 0
    private var wrongCount: Int = 0
        
    // ------------------------------------------------
    // MARK: init
    // ------------------------------------------------
    public init(levelManager: SoundQuizLevelManager<Quiz>, achievement: Achievement) {
        self.levelManager = levelManager
        self.achievement = achievement
        quizzes = levelManager.quizzes()
    }
}

// MARK: - SoundQuizUseCase
extension SoundQuizInteractor: SoundQuizUseCase {
    // ------------------------------------------------
    // MARK: 🌎🧮 computed properties
    // ------------------------------------------------
    public var star1Description: String { levelManager.star1.description }
    public var star2Description: String { levelManager.star2.description }
    public var star3Description: String { levelManager.star3.description }
    
    public var quizCount: Int {
        quizzes.count
    }
    public var timeLimit: Double {
        levelManager.timeLimit
    }
    public var penalty: PenaltyType {
        levelManager.penalty
    }
    
    // ------------------------------------------------
    // MARK: 🌎🛠️ methods
    // ------------------------------------------------
    public func answer(isCorrect: Bool) {
        if isCorrect {
            correctCount += 1
        } else {
            wrongCount += 1
        }
    }
    
    public func nextQuiz() -> Quiz {
        quizzes[min(correctCount, quizCount - 1)]
    }
    
    public func gameResult(time: Double) -> GameResult {
        if correctCount == quizCount {
            let star1 = levelManager.star1.isUnlock(time, wrongCount)
            let star2 = levelManager.star2.isUnlock(time, wrongCount)
            let star3 = levelManager.star3.isUnlock(time, wrongCount)
            Task.detached {
                try await Repository.updateAchievement(
                    .init(
                        record: min(self.achievement.record ?? .infinity, time),
                        star1: self.achievement.star1 || star1,
                        star2: self.achievement.star2 || star2,
                        star3: self.achievement.star3 || star3
                    )
                )
            }
            return .success(
                .init(
                    star1: .init(before: achievement.star1, after: star1),
                    star2: .init(before: achievement.star2, after: star2),
                    star3: .init(before: achievement.star3, after: star3)
                )
            )
        } else if time >= levelManager.timeLimit {
            return .timeOver
        } else {
            return .gameOver
        }
    }
    
    public func refresh() async throws {
        achievement = try await Repository.fetchAchievement()
        quizzes = levelManager.quizzes()
        correctCount = 0
        wrongCount = 0
    }
}
