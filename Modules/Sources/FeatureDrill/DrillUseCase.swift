//
//  DrillUseCase.swift
//  
//
//  Created by 若江照仁 on 2023/02/19.
//

import Foundation
import Core
import Repository

public protocol DrillUseCase<Drill> {
    associatedtype Drill: CoreDrill
    var lastRecord: DrillRecord { get }
    var timeLimit: Double { get }
    var verifyDuration: Double { get }
    var penalty: PenaltyType { get }
    
    var drillCount: Int { get }
    var wrongCount: Int { get }
    
    var levelTitle: String { get }
    var requirements: String { get }
    var star1Description: String { get }
    var star2Description: String { get }
    var star3Description: String { get }
    
    func recordDrillResult(isCorrect: Bool)
    func nextDrill() -> Drill
    func drillResult(time: Double) -> DrillResult
    func refresh() async throws
}

// MARK: - Dummy!!
#if DEBUG
public final class DrillUseCaseDummy: DrillUseCase {
    private var drills: [Drill] = [
        .init(options: Drill.Option.allCases)
    ]
    private var correctCount: Int = 0
    public var wrongCount: Int = 0
    public func nextDrill() -> DrillDummy {
        drills[min(correctCount, drills.count - 1)]
    }
    
    public typealias Drill = DrillDummy
    
    public var lastRecord: DrillRecord
    
    public let timeLimit: Double
    public let verifyDuration: Double = 0.4
    public var penalty: PenaltyType
    
    public var drillCount: Int { drills.count }
    
    public let levelTitle: String
    public let requirements: String
    public let star1Description: String
    public let star2Description: String
    public let star3Description: String
    
    public func recordDrillResult(isCorrect: Bool) {
        if isCorrect {
            correctCount += 1
        } else {
            wrongCount += 1
        }
    }
    
    public func drillResult(time: Double) -> DrillResult {
        if correctCount == drillCount {
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
        lastRecord: DrillRecord = .init(
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

public final class DrillInteractor<Drill: CoreDrill, Repository: DrillRecordRepository> {
    // ------------------------------------------------
    // MARK: 🌎📦public stored properties
    // ------------------------------------------------
    public var lastRecord: DrillRecord
    public var wrongCount: Int = 0
    
    // ------------------------------------------------
    // MARK: 🚪📦private stored properties
    // ------------------------------------------------
    private let generator: DrillGenerator<Drill>
    private var drills: [Drill]
    private var correctCount: Int = 0
        
    // ------------------------------------------------
    // MARK: init
    // ------------------------------------------------
    public init(generator: DrillGenerator<Drill>, lastRecord: DrillRecord) {
        self.generator = generator
        self.lastRecord = lastRecord
        drills = generator.generate()
    }
}

// MARK: - DrillUseCase
extension DrillInteractor: DrillUseCase {
    // ------------------------------------------------
    // MARK: 🌎🧮 computed properties
    // ------------------------------------------------
    public var levelTitle: String { generator.title }
    public var requirements: String { generator.requirements }
    public var star1Description: String { generator.star1.description }
    public var star2Description: String { generator.star2.description }
    public var star3Description: String { generator.star3.description }
    
    public var drillCount: Int {
        drills.count
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
    public func recordDrillResult(isCorrect: Bool) {
        if isCorrect {
            correctCount += 1
        } else {
            wrongCount += 1
        }
    }
    
    public func nextDrill() -> Drill {
        drills[min(correctCount, drillCount - 1)]
    }
    
    public func drillResult(time: Double) -> DrillResult {
        if correctCount == drillCount {
            let newRecord = generator.newRecord(time: time, wrongCount: wrongCount)
            Task.detached {
                // save
                try await Repository.updateDrillRecord(drillRecord: self.lastRecord.merged(newRecord))
                // open next if needed
                try await self.openNextDrillIfNeeded()
            }
            return .success(.init(lastRecord: lastRecord, newRecord: newRecord))
        } else if time >= generator.timeLimit {
            return .timeOver
        } else {
            return .gameOver
        }
    }
    
    public func refresh() async throws {
        lastRecord = try await Repository.fetchDrillRecord(generatorID: generator.id) ?? .init(id: generator.id)
        drills = generator.generate()
        correctCount = 0
        wrongCount = 0
    }
}

private extension DrillInteractor {
    /// nextIDを持っていて、次のドリルのレコードがない場合のみ初期値レコードを更新
    func openNextDrillIfNeeded() async throws {
        guard
            let nextID = generator.nextID,
            (try await Repository.fetchDrillRecord(generatorID: nextID)) == nil
        else {
            return
        }
        try await Repository.updateDrillRecord(drillRecord: .init(id: nextID))
    }
}
