//
//  File.swift
//  
//
//  Created by 若江照仁 on 2023/02/16.
//

import Foundation

public enum PenaltyType {
    case shuffle
    case gameOver
}

public struct Star {
    public var description: String
    public var isUnlock: (Double, Int) -> Bool
    public init(description: String, isUnlock: @escaping (Double, Int) -> Bool) {
        self.description = description
        self.isUnlock = isUnlock
    }
}

public struct SoundQuizLevelManager<Quiz: SoundQuiz> {
    public var title: String
    public var quizzes: () -> [Quiz]
    public var timeLimit: Double
    public var penalty: PenaltyType
    public var star1: Star
    public var star2: Star
    public var star3: Star
    
    public init(
        title: String,
        quizzes: @escaping () -> [Quiz],
        timeLimit: Double,
        penalty: PenaltyType,
        star1: Star,
        star2: Star,
        star3: Star
    ) {
        self.title = title
        self.quizzes = quizzes
        self.timeLimit = timeLimit
        self.penalty = penalty
        self.star1 = star1
        self.star2 = star2
        self.star3 = star3
    }
}
