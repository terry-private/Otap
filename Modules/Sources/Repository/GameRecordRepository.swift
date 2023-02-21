//
//  GameRecordRepository.swift
//  
//
//  Created by 若江照仁 on 2023/02/16.
//

import Foundation
import Core

public protocol GameRecordRepository {
    static func fetchGameRecord() async throws -> GameRecord
    static func updateGameRecord(_ gameRecord: GameRecord) async throws
}
