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
    static func fetchGameRecord(id: Int) async throws -> GameRecord?
}

public enum SelectLevelInteractor<Repository: GameRecordRepository>: SelectLevelUseCase {
    public static func fetchGameRecord(id: Int) async throws -> GameRecord? {
        try await Repository.fetchGameRecord(generatorID: id)
    }
}
