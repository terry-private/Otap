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
        await LocaleCache.shared.records[generatorID]
    }
    public static func updateGameRecord(generatorID: LevelSelectorID, gameRecord: Core.GameRecord) async throws {
        await LocaleCache.shared.update(id: generatorID, gameRecord)
    }
}
