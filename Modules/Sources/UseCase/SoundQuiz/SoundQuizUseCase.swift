//
//  SoundQuizUseCase.swift
//  
//
//  Created by 若江照仁 on 2023/02/19.
//

import Foundation
import Core

public protocol SoundQuizUseCase<Quiz> {
    associatedtype Quiz: SoundQuiz
    var lastRecord: GameRecord { get }
    var timeLimit: Double { get }
    var penalty: PenaltyType { get }
    
    var quizCount: Int { get }
    
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
public final class SoundQuizUseCaseDummy: SoundQuizUseCase {
    private var quizzes: [Quiz] = [
        .init(options: Quiz.Option.allCases)
    ]
    private var correctCount: Int = 0
    private var wrongCount: Int = 0
    public func nextQuiz() -> SoundQuizDummy {
        quizzes[min(correctCount, quizzes.count - 1)]
    }
    
    public typealias Quiz = SoundQuizDummy
    
    public var lastRecord: GameRecord
    
    public let timeLimit: Double
    public var penalty: PenaltyType
    
    public var quizCount: Int { quizzes.count }
    
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
            star1: false,
            star2: false,
            star3: false
        ),
        timeLimit: Double = 60,
        penalty: PenaltyType = .shuffle,
        star1Description: String = "クリア",
        star2Description: String = "ノーミス",
        star3Description: String = "40秒以内"
    ) {
        self.lastRecord = lastRecord
        self.timeLimit = timeLimit
        self.penalty = penalty
        self.star1Description = star1Description
        self.star2Description = star2Description
        self.star3Description = star3Description
    }
}
#endif
