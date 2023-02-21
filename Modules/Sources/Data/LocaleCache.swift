//
//  File.swift
//  
//
//  Created by 若江照仁 on 2023/02/20.
//

import Core

public final actor LocaleCache {
    private init() {}
    public static var shared: LocaleCache = .init()
    
    public var record: GameRecord = .init(star1: false, star2: false, star3: false)
    
    public func update(_ gameRecord: GameRecord) {
        self.record.merge(gameRecord)
    }
}
