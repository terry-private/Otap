//
//  File.swift
//  
//
//  Created by 若江照仁 on 2023/02/24.
//

import Foundation
import Core
import Feature
import Repository

public enum SelectCategoryInteractor<Repository: GameRecordRepository>: SelectCategoryUseCase {
    public static func fetchGameRecord(id: Int) async throws -> GameRecord? {
        try await Repository.fetchGameRecord(generatorID: id)
    }
}
