//
//  GameRecordRepository.swift
//  
//
//  Created by 若江照仁 on 2023/02/16.
//

import Foundation
import Core

public protocol GameRecordRepository {
    static func fetchGameRecord(generatorID: LevelSelectorID) async throws -> GameRecord?
    static func updateGameRecord(generatorID: LevelSelectorID, gameRecord: GameRecord) async throws
}

#if DEBUG
enum GameRecordRepositoryDummy: GameRecordRepository {
    static var record: GameRecord = .init(star1: false, star2: false, star3: false)
    static func fetchGameRecord(generatorID: LevelSelectorID) async throws -> Core.GameRecord? {
        record
    }
    static func updateGameRecord(generatorID: LevelSelectorID, gameRecord: Core.GameRecord) async throws {
        record = gameRecord
    }
}
#endif
