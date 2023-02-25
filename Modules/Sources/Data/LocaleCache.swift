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
    
    public var records: [Int: GameRecord] = [0: .init(star1: false, star2: false, star3: false)]
    
    public func update(id: Int, _ gameRecord: GameRecord) {
        records[id, default: .init(star1: false, star2: false, star3: false)].merge(gameRecord)
    }
}
