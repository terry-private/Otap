//
//  Achievement.swift
//  
//
//  Created by 若江照仁 on 2023/02/15.
//

import Foundation

public struct Achievement {
    public var record: Double?
    public var star1: Bool
    public var star2: Bool
    public var star3: Bool
    public init(record: Double? = nil, star1: Bool, star2: Bool, star3: Bool) {
        self.record = record
        self.star1 = star1
        self.star2 = star2
        self.star3 = star3
    }
    
}

// MARK: - ✉️
public extension Achievement {
    public mutating func merge(_ achievement: Self) {
        self = merged(achievement)
    }
    
    public func merged(_ achievement: Self) -> Self {
        let newRecord: Double?
        if self.record == nil && achievement.record == nil {
            newRecord = nil
        } else {
            newRecord = min(achievement.record ?? .infinity, self.record ?? .infinity)
        }
        return .init(
            record: newRecord,
            star1: achievement.star1 || self.star1,
            star2: achievement.star2 || self.star2,
            star3: achievement.star3 || self.star3
        )
    }
}
