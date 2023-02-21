//
//  SoundQuizInteractor.swift
//  
//
//  Created by 若江照仁 on 2023/02/15.
//

import Foundation
import UseCase
import Core
import Repository

public final class SoundQuizInteractor<Quiz: SoundQuiz, Repository: AchievementRepository> {
    // ------------------------------------------------
    // MARK: 🌎📦public stored properties
    // ------------------------------------------------
    public var achievement: Achievement
    
    // ------------------------------------------------
    // MARK: 🚪📦private stored properties
    // ------------------------------------------------
    private let generator: SoundQuizGenerator<Quiz>
    private var quizzes: [Quiz]
    private var correctCount: Int = 0
    private var wrongCount: Int = 0
        
    // ------------------------------------------------
    // MARK: init
    // ------------------------------------------------
    public init(generator: SoundQuizGenerator<Quiz>, achievement: Achievement) {
        self.generator = generator
        self.achievement = achievement
        quizzes = generator.quizzes()
    }
}

// MARK: - SoundQuizUseCase
extension SoundQuizInteractor: SoundQuizUseCase {
    // ------------------------------------------------
    // MARK: 🌎🧮 computed properties
    // ------------------------------------------------
    public var star1Description: String { generator.star1.description }
    public var star2Description: String { generator.star2.description }
    public var star3Description: String { generator.star3.description }
    
    public var quizCount: Int {
        quizzes.count
    }
    public var timeLimit: Double {
        generator.timeLimit
    }
    public var penalty: PenaltyType {
        generator.penalty
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
            let newAchievement = generator.newAchievement(time: time, wrongCount: wrongCount)
            Task.detached {
                try await Repository.updateAchievement(
                    self.achievement.merged(newAchievement)
                )
            }
            return .success(.init(oldAchievement: achievement, newAchievement: newAchievement))
        } else if time >= generator.timeLimit {
            return .timeOver
        } else {
            return .gameOver
        }
    }
    
    public func refresh() async throws {
        achievement = try await Repository.fetchAchievement()
        quizzes = generator.quizzes()
        correctCount = 0
        wrongCount = 0
    }
}
