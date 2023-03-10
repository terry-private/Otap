//
//  SelectLevelUseCase.swift
//  
//
//  Created by 若江照仁 on 2023/02/24.
//

import Foundation
import Core
import Repository

public protocol SelectLevelUseCase {
    static func fetchDrillRecord(id: LevelSelectorID) async throws -> DrillRecord?
}

public enum SelectLevelInteractor<Repository: DrillRecordRepository>: SelectLevelUseCase {
    public static func fetchDrillRecord(id: LevelSelectorID) async throws -> DrillRecord? {
        try await Repository.fetchDrillRecord(generatorID: id)
    }
}
