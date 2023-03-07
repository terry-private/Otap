//
//  GameRecord.swift
//  
//
//  Created by 若江照仁 on 2023/02/15.
//

import Foundation

public struct GameRecord: Identifiable, Hashable {
    public let id: LevelSelectorID
    public var time: Double?
    public var star1: Bool
    public var star2: Bool
    public var star3: Bool
    public init(id: LevelSelectorID, time: Double? = nil, star1: Bool = false, star2: Bool = false, star3: Bool = false) {
        self.id = id
        self.time = time
        self.star1 = star1
        self.star2 = star2
        self.star3 = star3
    }
}

public extension GameRecord {
    mutating func merge(_ record: Self) {
        self = merged(record)
    }
    
    func merged(_ record: Self) -> Self {
        guard record.id == id else { return self }
        let newTime: Double?
        if self.time == nil && record.time == nil {
            newTime = nil
        } else {
            newTime = min(record.time ?? .infinity, self.time ?? .infinity)
        }
        return .init(
            id: id,
            time: newTime,
            star1: record.star1 || self.star1,
            star2: record.star2 || self.star2,
            star3: record.star3 || self.star3
        )
    }
}
