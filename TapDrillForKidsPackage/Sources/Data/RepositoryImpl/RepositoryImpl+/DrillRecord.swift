//
//  DrillRecord+RepositoryImpl.swift
//  
//
//  Created by 若江照仁 on 2023/02/20.
//

import Foundation
import Core
import Repository

extension RepositoryImpl: DrillRecordRepository {    
    public static func fetchDrillRecord(generatorID: LevelSelectorID) async throws -> DrillRecord? {
        guard let record = RealmClientImpl.readDrillRecord(for: generatorID) else {
            return await LocaleCache.shared.records[generatorID]
        }
        return record
    }
    public static func updateDrillRecord(drillRecord: Core.DrillRecord) async throws {
        RealmClientImpl.updateDrillRecord(drillRecord)
    }
}
