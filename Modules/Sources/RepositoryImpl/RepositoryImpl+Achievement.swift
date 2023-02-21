//
//  RepositoryImpl+Achievement.swift
//  
//
//  Created by 若江照仁 on 2023/02/20.
//

import Foundation
import Core
import Data
import Repository

extension RepositoryImpl: AchievementRepository {
    public static func fetchAchievement() async throws -> Achievement {
        await LocaleCache.shared.achievement
    }
    public static func updateAchievement(_ achievement: Achievement) async throws {
        await LocaleCache.shared.update(achievement)
    }
}
