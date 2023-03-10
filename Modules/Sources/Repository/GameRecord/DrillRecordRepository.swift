//
//  DrillRecordRepository.swift
//  
//
//  Created by 若江照仁 on 2023/02/16.
//

import Foundation
import Core

public protocol DrillRecordRepository {
    static func fetchDrillRecord(generatorID: LevelSelectorID) async throws -> DrillRecord?
    static func updateDrillRecord(drillRecord: DrillRecord) async throws
}

#if DEBUG
enum DrillRecordRepositoryDummy: DrillRecordRepository {
    static func fetchDrillRecord(generatorID: LevelSelectorID) async throws -> Core.DrillRecord? {
        .init(id: generatorID)
    }
    static func updateDrillRecord(drillRecord: Core.DrillRecord) async throws {}
}
#endif
