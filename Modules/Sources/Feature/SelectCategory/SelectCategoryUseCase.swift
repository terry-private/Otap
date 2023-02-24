//
//  File.swift
//  
//
//  Created by 若江照仁 on 2023/02/24.
//

import Foundation
import Core

public protocol SelectCategoryUseCase {
    static func fetchGameRecord(id: Int) async throws -> GameRecord?
}
