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
    
    public var records: [Int: GameRecord] = [
        0: .init(),
        7: .init(),
        11: .init(),
        16: .init(),
        17: .init(),
        18: .init(),
        19: .init()
    ]
    
    public func update(id: Int, _ gameRecord: GameRecord) {
        records[id, default: .init()].merge(gameRecord)
    }
}
