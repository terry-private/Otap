//
//  RepositoryImpl+GameRecord.swift
//  
//
//  Created by 若江照仁 on 2023/02/20.
//

import Foundation
import Core
import Data

extension RepositoryImpl: GameRecordRepository {    
    public static func fetchGameRecord(generatorID: LevelSelectorID) async throws -> GameRecord? {
        guard let record = RealmClientImpl.readGameRecord(for: generatorID) else {
            return await LocaleCache.shared.records[generatorID]
        }
        return record
    }
    public static func updateGameRecord(gameRecord: Core.GameRecord) async throws {
        RealmClientImpl.updateGameRecord(gameRecord)
    }
}
