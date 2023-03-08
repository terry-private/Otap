//
//  VoiceQuizUseCase.swift
//  
//
//  Created by 若江照仁 on 2023/02/19.
//

import Foundation
import Core
import Repository

public protocol VoiceQuizUseCase<Quiz> {
    associatedtype Quiz: VoiceQuiz
    var lastRecord: GameRecord { get }
    var timeLimit: Double { get }
    var verifyDuration: Double { get }
    var penalty: PenaltyType { get }
    
    var quizCount: Int { get }
    var wrongCount: Int { get }
    
    var levelTitle: String { get }
    var requirements: String { get }
    var star1Description: String { get }
    var star2Description: String { get }
    var star3Description: String { get }
    
    func recordQuizResult(isCorrect: Bool)
    func nextQuiz() -> Quiz
    func gameResult(time: Double) -> GameResult
    func refresh() async throws
}

// MARK: - Dummy!!
#if DEBUG
public final class VoiceQuizUseCaseDummy: VoiceQuizUseCase {
    private var quizzes: [Quiz] = [
        .init(options: Quiz.Option.allCases)
    ]
    private var correctCount: Int = 0
    public var wrongCount: Int = 0
    public func nextQuiz() -> VoiceQuizDummy {
        quizzes[min(correctCount, quizzes.count - 1)]
    }
    
    public typealias Quiz = VoiceQuizDummy
    
    public var lastRecord: GameRecord
    
    public let timeLimit: Double
    public let verifyDuration: Double = 0.4
    public var penalty: PenaltyType
    
    public var quizCount: Int { quizzes.count }
    
    public let levelTitle: String
    public let requirements: String
    public let star1Description: String
    public let star2Description: String
    public let star3Description: String
    
    public func recordQuizResult(isCorrect: Bool) {
        if isCorrect {
            correctCount += 1
        } else {
            wrongCount += 1
        }
    }
    
    public func gameResult(time: Double) -> GameResult {
        if correctCount == quizCount {
            return .success(
                .init(
                    star1: .init(before: lastRecord.star1, after: true),
                    star2: .init(before: lastRecord.star2, after: true),
                    star3: .init(before: lastRecord.star3, after: false),
                    time: time,
                    isNewTimeRecord: lastRecord.time ?? .infinity > time
                )
            )
        } else if time >= timeLimit {
            return .timeOver
        } else {
            return .gameOver
        }
    }
    
    public func refresh() async throws {
        correctCount = 0
        wrongCount = 0
    }
    
    public init(
        lastRecord: GameRecord = .init(
            id: .colorBasic1,
            star1: false,
            star2: false,
            star3: false
        ),
        timeLimit: Double = 60,
        penalty: PenaltyType = .shuffle,
        levelTitle: String = "基本1",
        requirements: String = "30秒以内に10問",
        star1Description: String = "クリア",
        star2Description: String = "ノーミス",
        star3Description: String = "40秒以内"
    ) {
        self.lastRecord = lastRecord
        self.timeLimit = timeLimit
        self.penalty = penalty
        self.levelTitle = levelTitle
        self.requirements = requirements
        self.star1Description = star1Description
        self.star2Description = star2Description
        self.star3Description = star3Description
    }
}
#endif

public final class VoiceQuizInteractor<Quiz: VoiceQuiz, Repository: GameRecordRepository> {
    // ------------------------------------------------
    // MARK: 🌎📦public stored properties
    // ------------------------------------------------
    public var lastRecord: GameRecord
    public var wrongCount: Int = 0
    
    // ------------------------------------------------
    // MARK: 🚪📦private stored properties
    // ------------------------------------------------
    private let generator: VoiceQuizGenerator<Quiz>
    private var quizzes: [Quiz]
    private var correctCount: Int = 0
        
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
    public var levelTitle: String { generator.title }
    public var requirements: String { generator.requirements }
    public var star1Description: String { generator.star1.description }
    public var star2Description: String { generator.star2.description }
    public var star3Description: String { generator.star3.description }
    
    public var quizCount: Int {
        quizzes.count
    }
    public var verifyDuration: Double { 0.4 }
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
                try await Repository.updateGameRecord(gameRecord: self.lastRecord.merged(newRecord))
                // open next if needed
                if let nextID = self.generator.nextID {
                    try await Repository.updateGameRecord(gameRecord: .init(id: nextID))
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
        lastRecord = try await Repository.fetchGameRecord(generatorID: generator.id) ?? .init(id: generator.id)
        quizzes = generator.quizzes()
        correctCount = 0
        wrongCount = 0
    }
}
