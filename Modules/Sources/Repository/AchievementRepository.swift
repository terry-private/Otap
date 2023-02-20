//
//  File.swift
//  
//
//  Created by 若江照仁 on 2023/02/16.
//

import Foundation
import Core

public protocol AchievementRepository {
    static func fetchAchievement() async throws -> Achievement
    static func updateAchievement(_ achievement: Achievement) async throws
}
