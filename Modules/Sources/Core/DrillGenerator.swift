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

public struct DrillGenerator<Drill: CoreDrill>: Identifiable {
    public var id: LevelSelectorID
    public var nextID: LevelSelectorID?
    public var title: String
    public var requirements: String
    public var generate: () -> [Drill]
    public var previewDrill: Drill
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
        generate: @escaping () -> [Drill],
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
        self.generate = generate
        self.previewDrill = generate().first!
        self.timeLimit = timeLimit
        self.penalty = penalty
        self.star1 = star1
        self.star2 = star2
        self.star3 = star3
    }
}

public extension DrillGenerator {
    func newRecord(time: Double, wrongCount: Int) -> DrillRecord {
        let star1 = star1.isUnlock(time, wrongCount)
        let star2 = star2.isUnlock(time, wrongCount)
        let star3 = star3.isUnlock(time, wrongCount)
        return .init(id: id,time: time, star1: star1, star2: star2, star3: star3)
    }
}
