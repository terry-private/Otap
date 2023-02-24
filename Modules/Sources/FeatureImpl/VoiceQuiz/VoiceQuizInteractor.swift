//
//  VoiceQuizInteractor.swift
//  
//
//  Created by 若江照仁 on 2023/02/15.
//

import Foundation
import UseCase
import Core
import Repository
import Feature

public final class VoiceQuizInteractor<Quiz: VoiceQuiz, Repository: GameRecordRepository> {
    // ------------------------------------------------
    // MARK: 🌎📦public stored properties
    // ------------------------------------------------
    public var lastRecord: GameRecord
    
    // ------------------------------------------------
    // MARK: 🚪📦private stored properties
    // ------------------------------------------------
    private let generator: VoiceQuizGenerator<Quiz>
    private var quizzes: [Quiz]
    private var correctCount: Int = 0
    private var wrongCount: Int = 0
        
    // ------------------------------------------------
    // MARK: init
    // ------------------------------------------------
    public init(generator: VoiceQuizGenerator<Quiz>, lastRecord: GameRecord) {
        self.generator = generator
        self.lastRecord = lastRecord
        quizzes = generator.quizzes()
    }
}

// MARK: - VoiceQuizUseCase
extension VoiceQuizInteractor: VoiceQuizUseCase {
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
    public func recordQuizResult(isCorrect: Bool) {
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
            let newRecord = generator.newRecord(time: time, wrongCount: wrongCount)
            Task.detached {
                // save
                try await Repository.updateGameRecord(
                    generatorID: self.generator.id, gameRecord: self.lastRecord.merged(newRecord)
                )
                // open next if needed
                if let nextID = self.generator.nextID, try await Repository.fetchGameRecord(generatorID: nextID) == nil {
                    try await Repository.updateGameRecord(generatorID: nextID, gameRecord: .init(star1: false, star2: false, star3: false))
                }
            }
            return .success(.init(lastRecord: lastRecord, newRecord: newRecord))
        } else if time >= generator.timeLimit {
            return .timeOver
        } else {
            return .gameOver
        }
    }
    
    public func refresh() async throws {
        lastRecord = try await Repository.fetchGameRecord(generatorID: generator.id) ?? .init(star1: false, star2: false, star3: false)
        quizzes = generator.quizzes()
        correctCount = 0
        wrongCount = 0
    }
}
