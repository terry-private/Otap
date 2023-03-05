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
    static func updateGameRecord(gameRecord: GameRecord) async throws
}

#if DEBUG
enum GameRecordRepositoryDummy: GameRecordRepository {
    static func fetchGameRecord(generatorID: LevelSelectorID) async throws -> Core.GameRecord? {
        .init(id: generatorID)
    }
    static func updateGameRecord(gameRecord: Core.GameRecord) async throws {}
}
#endif
