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
    
    /// 達成判定ロジック: (クリア時間, 失敗数) -> 達成したかどうか
    public var isUnlock: (Double, Int) -> Bool
    
    /// 初期化
    /// - Parameters:
    ///   - description: 達成条件の説明文
    ///   - isUnlock: 達成判定ロジック: (クリア時間, 失敗数) -> 達成したかどうか
    public init(description: String, isUnlock: @escaping (Double, Int) -> Bool) {
        self.description = description
        self.isUnlock = isUnlock
    }
}

public struct VoiceQuizGenerator<Quiz: VoiceQuiz>: Identifiable {
    public var id: LevelSelectorID
    public var nextID: LevelSelectorID?
    public var title: String
    public var requirements: String
    public var quizzes: () -> [Quiz]
    public var previewQuiz: Quiz
    public var timeLimit: Double
    public var penalty: PenaltyType
    public var star1: Star
    public var star2: Star
    public var star3: Star
    
    public init(
        id: LevelSelectorID,
        nextID: LevelSelectorID?,
        title: String,
        requirements: String,
        quizzes: @escaping () -> [Quiz],
        timeLimit: Double,
        penalty: PenaltyType,
        star1: Star,
        star2: Star,
        star3: Star
    ) {
        self.id = id
        self.nextID = nextID
        self.title = title
        self.requirements = requirements
        self.quizzes = quizzes
        self.previewQuiz = quizzes().first!
        self.timeLimit = timeLimit
        self.penalty = penalty
        self.star1 = star1
        self.star2 = star2
        self.star3 = star3
    }
}

public extension VoiceQuizGenerator {
    func newRecord(time: Double, wrongCount: Int) -> GameRecord {
        let star1 = star1.isUnlock(time, wrongCount)
        let star2 = star2.isUnlock(time, wrongCount)
        let star3 = star3.isUnlock(time, wrongCount)
        return .init(time: time, star1: star1, star2: star2, star3: star3)
    }
}

/// ⚠️実装に依存しています。(IDがユニークかどうかチェックするためにenumでID型を定義したい)
public enum LevelSelectorID: Int {
    case colorLevel1 = 0
    case colorLevel2 = 1
    case colorLevel3 = 2
    case colorLevel4 = 3
    case colorLevel5 = 4
    case colorLevel6 = 5
    case colorLevel7 = 6
    
    case animalFunny1 = 7
    case animalFunny2 = 8
    case animalFunny3 = 9
    case animalFunny4 = 10
    case animalAnimal1 = 11
    case animalAnimal2 = 12
    case animalAnimal3 = 13
    case animalAnimal4 = 14
    case animalAnimal5 = 15
    case animalBird = 16
    case animalReptile = 17
    case animalMarineLife = 18
    case animalInsect = 19
    case animalAll1 = 20
    case animalAll2 = 21
}
