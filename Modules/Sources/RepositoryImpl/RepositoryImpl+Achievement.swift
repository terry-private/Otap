//
//  File.swift
//  
//
//  Created by 若江照仁 on 2023/02/20.
//

import Foundation
import Core
import Repository

public final actor LocaleCache {
    private init() {}
    public static var shared: LocaleCache = .init()
    var achievement: Achievement = .init(star1: false, star2: false, star3: false)
    func update(_ achievement: Achievement) {
        self.achievement.merge(achievement)
    }
}

public enum RepositoryImpl: AchievementRepository {
    public static func fetchAchievement() async throws -> Achievement {
        await LocaleCache.shared.achievement
    }
    public static func updateAchievement(_ achievement: Achievement) async throws {
        await LocaleCache.shared.update(achievement)
    }
}
