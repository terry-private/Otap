//
//  File.swift
//  
//
//  Created by 若江照仁 on 2023/02/16.
//

import Foundation
import Core

public final actor LocaleCache {
    private init() {}
    public static var shared: LocaleCache = .init()
    var achievement: Achievement = .init(star1: false, star2: false, star3: false)
    func update(_ achievement: Achievement) {
        self.achievement.merge(achievement)
    }
}

// 📁 repository
public protocol SoundQuizRepositoryProtocol {
    static func fetchAchievement() async throws -> Achievement
    static func updateAchievement(_ achievement: Achievement) async throws
}

public enum SoundQuizRepositoryImpl: SoundQuizRepositoryProtocol {
    public static func fetchAchievement() async throws -> Achievement {
        await LocaleCache.shared.achievement
    }
    public static func updateAchievement(_ achievement: Achievement) async throws {
        await LocaleCache.shared.update(achievement)
    }
}
