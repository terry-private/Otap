//
//  RepositoryImpl+GameRecord.swift
//  
//
//  Created by 若江照仁 on 2023/02/20.
//

import Foundation
import Core
import Data
import Repository

extension RepositoryImpl: GameRecordRepository {
    public static func fetchGameRecord() async throws -> GameRecord {
        await LocaleCache.shared.record
    }
    public static func updateGameRecord(_ gameRecord: GameRecord) async throws {
        await LocaleCache.shared.update(gameRecord)
    }
}
